Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by ozlabs.org (Postfix) with ESMTP id 106EA2C0094
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Sep 2013 20:16:19 +1000 (EST)
Subject: Re: [RFC PATCH 00/11 Allow PR and HV KVM to coexist in one kernel
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <878uyibkq2.fsf@linux.vnet.ibm.com>
Date: Mon, 30 Sep 2013 12:16:14 +0200
Message-Id: <48337EF0-471D-4BDB-8088-FC072FF82753@suse.de>
References: <1380276233-17095-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <878uyibkq2.fsf@linux.vnet.ibm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: "<kvm@vger.kernel.org> list" <kvm@vger.kernel.org>,
 Gleb Natapov <gleb@redhat.com>, kvm-ppc@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, Paolo Bonzini <pbonzini@redhat.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 27.09.2013, at 12:52, Aneesh Kumar K.V wrote:

> "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> writes:
>=20
>> Hi All,
>>=20
>> This patch series support enabling HV and PR KVM together in the same =
kernel. We
>> extend machine property with new property "kvm_type". A value of 1 =
will force HV
>> KVM and 2 PR KVM. The default value is 0 which will select the =
fastest KVM mode.
>> ie, HV if that is supported otherwise PR.
>>=20
>> With Qemu command line having
>>=20
>> -machine pseries,accel=3Dkvm,kvm_type=3D1
>>=20
>> [root@llmp24l02 qemu]# bash ../qemu
>> failed to initialize KVM: Invalid argument
>> [root@llmp24l02 qemu]# modprobe kvm-pr
>> [root@llmp24l02 qemu]# bash ../qemu
>> failed to initialize KVM: Invalid argument
>> [root@llmp24l02 qemu]# modprobe  kvm-hv
>> [root@llmp24l02 qemu]# bash ../qemu
>>=20
>> now with
>>=20
>> -machine pseries,accel=3Dkvm,kvm_type=3D2
>>=20
>> [root@llmp24l02 qemu]# rmmod kvm-pr
>> [root@llmp24l02 qemu]# bash ../qemu
>> failed to initialize KVM: Invalid argument
>> [root@llmp24l02 qemu]#
>> [root@llmp24l02 qemu]# modprobe kvm-pr
>> [root@llmp24l02 qemu]# bash ../qemu
>>=20
>> if don't specify kvm_type machine property, it will take a default =
value 0,
>> which means fastest supported.
>=20
> Related qemu patch
>=20
> commit 8d139053177d48a70cb710b211ea4c2843eccdfb
> Author: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> Date:   Mon Sep 23 12:28:37 2013 +0530
>=20
>    kvm: Add a new machine property kvm_type
>=20
>    Targets like ppc64 support different type of KVM, one which use
>    hypervisor mode and the other which doesn't. Add a new machine
>    property kvm_type that helps in selecting the respective ones
>=20
>    Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

This really is too early, as we can't possibly run in HV mode for =
non-pseries machines, so the interpretation (or at least sanity =
checking) of what values are reasonable should occur in the machine. =
That's why it's a variable in the "machine opts".

Also, users don't want to say type=3D0. They want to say type=3DPR or =
type=3DHV or type=3DHV,PR. In fact, can't you make this a property of =
-accel? Then it's truly accel specific and everything should be well.


Alex

>=20
> diff --git a/kvm-all.c b/kvm-all.c
> index b87215c..a061eda 100644
> --- a/kvm-all.c
> +++ b/kvm-all.c
> @@ -1350,7 +1350,7 @@ int kvm_init(void)
>     KVMState *s;
>     const KVMCapabilityInfo *missing_cap;
>     int ret;
> -    int i;
> +    int i, kvm_type;
>     int max_vcpus;
>=20
>     s =3D g_malloc0(sizeof(KVMState));
> @@ -1407,7 +1407,8 @@ int kvm_init(void)
>         goto err;
>     }
>=20
> -    s->vmfd =3D kvm_ioctl(s, KVM_CREATE_VM, 0);
> +    kvm_type =3D qemu_opt_get_number(qemu_get_machine_opts(), =
"kvm_type", 0);
> +    s->vmfd =3D kvm_ioctl(s, KVM_CREATE_VM, kvm_type);
>     if (s->vmfd < 0) {
> #ifdef TARGET_S390X
>         fprintf(stderr, "Please add the 'switch_amode' kernel =
parameter to "
> diff --git a/vl.c b/vl.c
> index 4e709d5..4374b17 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -427,7 +427,12 @@ static QemuOptsList qemu_machine_opts =3D {
>             .name =3D "usb",
>             .type =3D QEMU_OPT_BOOL,
>             .help =3D "Set on/off to enable/disable usb",
> +        },{
> +            .name =3D "kvm_type",
> +            .type =3D QEMU_OPT_NUMBER,
> +            .help =3D "Set to kvm type to be used in create vm =
ioctl",
>         },
> +
>         { /* End of list */ }
>     },
> };
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe kvm-ppc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
