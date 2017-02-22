Return-Path: <gfree.wind@gmail.com>
Received: from mail-vk0-x244.google.com (mail-vk0-x244.google.com
 [IPv6:2607:f8b0:400c:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vSr2t0jqKzDqH6
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Feb 2017 19:22:46 +1100 (AEDT)
Received: by mail-vk0-x244.google.com with SMTP id n125so263935vke.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Feb 2017 00:22:45 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1487751232.13163.24.camel@intel.com>
References: <1487748144-13685-1-git-send-email-fgao@ikuai8.com>
 <1487751232.13163.24.camel@intel.com>
From: Feng Gao <gfree.wind@gmail.com>
Date: Wed, 22 Feb 2017 16:22:43 +0800
Message-ID: <CA+6hz4rXi3XNu6xVeq_RkFT4yZwNFRaAD3Cuyb7yCFxA4U9UHw@mail.gmail.com>
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

On Wed, Feb 22, 2017 at 4:14 PM, Winkler, Tomas <tomas.winkler@intel.com> w=
rote:
> On Wed, 2017-02-22 at 15:22 +0800, fgao@ikuai8.com wrote:
>> From: Gao Feng <fgao@ikuai8.com>
>>
>> When make allyesconfig, there is one compile error on my platform
>> "gcc (Ubuntu 4.8.4-2ubuntu1~14.04.3) 4.8.4".
>> The following is the output.
>>
>> Documentation/misc-devices/mei/mei-amt-version.c: In function =E2=80=98m=
ain=E2=80=99:
>> Documentation/misc-devices/mei/mei-amt-version.c:103:5: warning:
>> =E2=80=98acmd.fd=E2=80=99
>> is used uninitialized in this function [-Wuninitialized]
>>   if (cl->fd !=3D -1)
>>      ^
>> Documentation/misc-devices/mei/mei-amt-version.c:443:21: note:
>> =E2=80=98acmd.fd=E2=80=99
>> was declared here
>>   struct amt_host_if acmd;
>>                      ^
>> This commit fixes this compile error.
>>
>> Signed-off-by: Gao Feng <fgao@ikuai8.com>
>
> This is false positive, as the variable is assined in mei_init(), in
> any case, the code has moved under samples diretory in the current
> kernel. Anything need to be fixed there first
>
> Thanks
> Tomas

I think it is not false positive.
The function stack is main->amt_host_if_init->mei_init->mei_deinit.
There is one check "if (cl->fd !=3D -1)".

Because this fd is not initialized to -1, so it may hit the condition,
and execute close.

So it should be fixed, although these codes would be moved to sample direct=
or.

Regards
Feng

>
>> ---
>>  Documentation/misc-devices/mei/mei-amt-version.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/Documentation/misc-devices/mei/mei-amt-version.c
>> b/Documentation/misc-devices/mei/mei-amt-version.c
>> index 49e4f77..ca035cb 100644
>> --- a/Documentation/misc-devices/mei/mei-amt-version.c
>> +++ b/Documentation/misc-devices/mei/mei-amt-version.c
>> @@ -297,6 +297,7 @@ static bool amt_host_if_init(struct amt_host_if
>> *acmd,
>>                     unsigned long send_timeout, bool verbose)
>>  {
>>       acmd->send_timeout =3D (send_timeout) ? send_timeout : 20000;
>> +     acmd->mei_cl.fd =3D -1;
>>       acmd->initialized =3D mei_init(&acmd->mei_cl, &MEI_IAMTHIF, 0,
>> verbose);
>>       return acmd->initialized;
>>  }
