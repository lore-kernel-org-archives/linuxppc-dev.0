Return-Path: <mahesh@linux.vnet.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp04.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2E8C42C00BA
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Apr 2013 11:43:55 +1000 (EST)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Wed, 10 Apr 2013 11:32:36 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 874F2357804A
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Apr 2013 11:43:49 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r3A1Tnde64880778
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Apr 2013 11:29:49 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r3A1hFBj007756
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Apr 2013 11:43:15 +1000
Message-ID: <5164C3B0.8090404@linux.vnet.ibm.com>
Date: Wed, 10 Apr 2013 07:13:12 +0530
From: Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Wang Sheng-Hui <shhuiw@gmail.com>
Subject: Re: [PATCH] fadump: allow duplicate assignment to
 /sys/kernel/fadump_registered
 when it's assigned the desired value already
References: <5164B664.6070306@gmail.com>
In-Reply-To: <5164B664.6070306@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 "Suzuki K. Poulose" <suzuki@in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/10/2013 06:16 AM, Wang Sheng-Hui wrote:
> When the fadump is enabled, we have /sys/kernel/fadump_enabled assigned 1.
> But sometimes we need to restart the fadump service by 'service kdump
> restart',
> in case the kdump script has added the fadump detect/support already.
> In current implementation, we cannot re-assign 1 to
> /sys/kernel/fadump_enabled

I assume you meant /sys/kernel/fadump_registered here. Ideally service
kdump restart should first echo 0 to /sys/kernel/fadump_registered to
un-register fadump before echo 1 to /sys/kernel/fadump_registered for
re-registration. I would fix the user space tool than changing the
kernel code.

> if 1 is already set and we have added more logic check in the user space
> script.
> 
> I think we can enable the duplicate assignment to ease the user space
> tools,
> as long as the value is the right 1 or 0.
> 
> Signed-off-by: Wang Sheng-Hui <shhuiw@gmail.com>
> ---
>  arch/powerpc/kernel/fadump.c |    8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
> index 06c8202..e1347e5 100644
> --- a/arch/powerpc/kernel/fadump.c
> +++ b/arch/powerpc/kernel/fadump.c
> @@ -1140,18 +1140,14 @@ static ssize_t fadump_register_store(struct
> kobject *kobj,
> 
>      switch (buf[0]) {
>      case '0':
> -        if (fw_dump.dump_registered == 0) {
> -            ret = -EINVAL;
> +        if (fw_dump.dump_registered == 0)
>              goto unlock_out;
> -        }
>          /* Un-register Firmware-assisted dump */
>          fadump_unregister_dump(&fdm);
>          break;
>      case '1':
> -        if (fw_dump.dump_registered == 1) {
> -            ret = -EINVAL;
> +        if (fw_dump.dump_registered == 1)
>              goto unlock_out;
> -        }
>          /* Register Firmware-assisted dump */
>          register_fadump();
>          break;
