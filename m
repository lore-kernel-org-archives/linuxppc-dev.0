Message-Id: <5.0.0.19.2.20000925173113.02e31040@mail.lauterbach.com>
Date: Mon, 25 Sep 2000 17:54:26 +0200
To: drepper@cygnus.com (Ulrich Drepper)
From: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>
Subject: Re: [RFC] IPC64 with glibc-2.2 and linux-2.4
Cc: libc-alpha@sources.redhat.com, linuxppc-dev@lists.linuxppc.org
In-Reply-To: <m366nko5ml.fsf@otr.mynet.cygnus.com>
References: <Franz Sirl's message of "Mon, 25 Sep 2000 11:10:45 +0200">
 <Franz Sirl's message of "Sun, 24 Sep 2000 21:50:44 +0200">
 <00092421504403.01070@enzo.bigblue.local>
 <5.0.0.19.2.20000925110119.01fe1df0@mail.lauterbach.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 17:25 25.09.00, Ulrich Drepper wrote:
>Franz Sirl <Franz.Sirl-kernel@lauterbach.com> writes:
>
> > What about 'seq'? Can I safely bump it to 32bit for userspace in the final
> > patch? I see no need for the kernel and userspace being different here, but
> > all other archs are limiting it to 16bit, so there may be a reason...
>
>You should avoid changing the size of the struct.  I haven't done the
>math on this.

Well, changing compared to what? IPC_64 on PPC was never functional so far,
so there is no problem here. The IPC_64 structs on the other archs have
this, eg on sparc:

struct ipc64_perm
{
         __kernel_key_t          key;
         __kernel_uid32_t        uid;
         __kernel_gid32_t        gid;
         __kernel_uid32_t        cuid;
         __kernel_gid32_t        cgid;
         unsigned short          __pad1;
         __kernel_mode_t         mode;
         unsigned short          __pad2;
         unsigned short          seq;
         unsigned long long      __unused1;
         unsigned long long      __unused2;
};

but internally the kernel uses:

/* used by in-kernel data structures */
struct kern_ipc_perm
{
         key_t           key;
         uid_t           uid;
         gid_t           gid;
         uid_t           cuid;
         gid_t           cgid;
         mode_t          mode;
         unsigned long   seq;
};

So, is there a reason why seq is limited to 16bit in the
kern_ipc_perm<->ipc64_perm interface in the kernel? ipc64_perm is prepared
for a 32bit value anyway with the __pad2 padding. Since I for myself can't
think of a valid reason for limiting seq to 16bit in userspace, I'm asking
here, cause I have not the slightest idea how the IPC is handled/used
outside of kernel/glibc. If there is no reason, I really would prefer to
change my patch to use 'unsigned long seq' on PPC.

Franz.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
