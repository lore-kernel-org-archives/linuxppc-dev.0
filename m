Return-Path: <gfree.wind@gmail.com>
Received: from mail-vk0-x243.google.com (mail-vk0-x243.google.com
 [IPv6:2607:f8b0:400c:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vTKft5GT2zDq5x
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Feb 2017 14:37:10 +1100 (AEDT)
Received: by mail-vk0-x243.google.com with SMTP id t8so1727075vke.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Feb 2017 19:37:10 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <5B8DA87D05A7694D9FA63FD143655C1B5439AD21@hasmsx108.ger.corp.intel.com>
References: <1487748144-13685-1-git-send-email-fgao@ikuai8.com>
 <1487751232.13163.24.camel@intel.com>
 <CA+6hz4rXi3XNu6xVeq_RkFT4yZwNFRaAD3Cuyb7yCFxA4U9UHw@mail.gmail.com>
 <5B8DA87D05A7694D9FA63FD143655C1B5439AD21@hasmsx108.ger.corp.intel.com>
From: Feng Gao <gfree.wind@gmail.com>
Date: Thu, 23 Feb 2017 11:37:07 +0800
Message-ID: <CA+6hz4pSPF=DPwUMmnV4EkMOkN9xmfBP7RAH9bFkZCqSNpB1jg@mail.gmail.com>
Subject: Re: [PATCH kernel 1/1] powerpc/Documentation/misc-devices/: Fix one
 compile error
To: "Winkler, Tomas" <tomas.winkler@intel.com>
Cc: "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "rob@landley.net" <rob@landley.net>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Feb 22, 2017 at 5:09 PM, Winkler, Tomas <tomas.winkler@intel.com> w=
rote:
>
>>
>> On Wed, Feb 22, 2017 at 4:14 PM, Winkler, Tomas <tomas.winkler@intel.com=
>
>> wrote:
>> > On Wed, 2017-02-22 at 15:22 +0800, fgao@ikuai8.com wrote:
>> >> From: Gao Feng <fgao@ikuai8.com>
>> >>
>> >> When make allyesconfig, there is one compile error on my platform
>> >> "gcc (Ubuntu 4.8.4-2ubuntu1~14.04.3) 4.8.4".
>> >> The following is the output.
>> >>
>> >> Documentation/misc-devices/mei/mei-amt-version.c: In function =E2=80=
=98main=E2=80=99:
>> >> Documentation/misc-devices/mei/mei-amt-version.c:103:5: warning:
>> >> =E2=80=98acmd.fd=E2=80=99
>> >> is used uninitialized in this function [-Wuninitialized]
>> >>   if (cl->fd !=3D -1)
>> >>      ^
>> >> Documentation/misc-devices/mei/mei-amt-version.c:443:21: note:
>> >> =E2=80=98acmd.fd=E2=80=99
>> >> was declared here
>> >>   struct amt_host_if acmd;
>> >>                      ^
>> >> This commit fixes this compile error.
>> >>
>> >> Signed-off-by: Gao Feng <fgao@ikuai8.com>
>> >
>> > This is false positive, as the variable is assined in mei_init(), in
>> > any case, the code has moved under samples diretory in the current
>> > kernel. Anything need to be fixed there first
>> >
>> > Thanks
>> > Tomas
>>
>> I think it is not false positive.
>> The function stack is main->amt_host_if_init->mei_init->mei_deinit.
>> There is one check "if (cl->fd !=3D -1)".
>
> Isn't  the first line in mei_init me->fd =3D open("/dev/mei", O_RDWR); ?
> I don't see mei_deinit called w/o mei_init called first.

The codes of powerpc.git(git://git.kernel.org/pub/scm/linux/kernel/git/gala=
k/powerpc.git)
are different with net.git.
The following are the codes from powerpc.git

static bool mei_init(struct mei *me, const uuid_le *guid,
                unsigned char req_protocol_version, bool verbose)
{
        int result;
        struct mei_client *cl;
        struct mei_connect_client_data data;

        mei_deinit(me);

        me->verbose =3D verbose;

        me->fd =3D open("/dev/mei", O_RDWR);
        if (me->fd =3D=3D -1) {
                mei_err(me, "Cannot establish a handle to the Intel
MEI driver\n");
                goto err;
        }

The mei_deinit is invoked before open, so the gcc reports one warning.

Regards
Feng


>
>> Because this fd is not initialized to -1, so it may hit the condition, a=
nd execute
>> close.
>>
>> So it should be fixed, although these codes would be moved to sample
>> director.
>
> Please try with the master branch first in case  I'm still wrong.
> Thanks
>
>> Regards
>> Feng
>>
>> >
>> >> ---
>> >>  Documentation/misc-devices/mei/mei-amt-version.c | 1 +
>> >>  1 file changed, 1 insertion(+)
>> >>
>> >> diff --git a/Documentation/misc-devices/mei/mei-amt-version.c
>> >> b/Documentation/misc-devices/mei/mei-amt-version.c
>> >> index 49e4f77..ca035cb 100644
>> >> --- a/Documentation/misc-devices/mei/mei-amt-version.c
>> >> +++ b/Documentation/misc-devices/mei/mei-amt-version.c
>> >> @@ -297,6 +297,7 @@ static bool amt_host_if_init(struct amt_host_if
>> >> *acmd,
>> >>                     unsigned long send_timeout, bool verbose)  {
>> >>       acmd->send_timeout =3D (send_timeout) ? send_timeout : 20000;
>> >> +     acmd->mei_cl.fd =3D -1;
>> >>       acmd->initialized =3D mei_init(&acmd->mei_cl, &MEI_IAMTHIF, 0,
>> >> verbose);
>> >>       return acmd->initialized;
>> >>  }
