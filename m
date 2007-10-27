Return-Path: <adobriyan@gmail.com>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.189])
	by ozlabs.org (Postfix) with ESMTP id BDB2EDDF06
	for <linuxppc-dev@ozlabs.org>; Sun, 28 Oct 2007 05:34:59 +1100 (EST)
Received: by nf-out-0910.google.com with SMTP id c10so1159532nfd
	for <linuxppc-dev@ozlabs.org>; Sat, 27 Oct 2007 11:34:58 -0700 (PDT)
Date: Sat, 27 Oct 2007 22:34:53 +0400
To: Mikael Pettersson <mikpe@it.uu.se>
Subject: Re: 2.6.24-rc1 sysctl table check failed on PowerMac
Message-ID: <20071027183453.GB9816@martell.zuzino.mipt.ru>
References: <200710271757.l9RHvcY9021751@harpo.it.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200710271757.l9RHvcY9021751@harpo.it.uu.se>
From: Alexey Dobriyan <adobriyan@gmail.com>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Oct 27, 2007 at 07:57:38PM +0200, Mikael Pettersson wrote:
> Booting 2.6.24-rc1 on my PowerMac the kernel now spits
> out a sysctl warning early in the boot sequence:
> 
> --- dmesg-2.6.23
> +++ dmesg-2.6.24-rc1
> ...
>  IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
>  TCP established hash table entries: 131072 (order: 8, 1048576 bytes)
>  TCP bind hash table entries: 65536 (order: 6, 262144 bytes)
>  TCP: Hash tables configured (established 131072 bind 65536)
>  TCP reno registered
> +sysctl table check failed: /kernel .1 Writable sysctl directory

[PATCH] powerpc: fix sysctl whining re kernel.powersave-nap

kernel was marked with 0755. Everywhere else it's 0555.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 arch/powerpc/kernel/idle.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/powerpc/kernel/idle.c
+++ b/arch/powerpc/kernel/idle.c
@@ -122,7 +122,7 @@ static ctl_table powersave_nap_sysctl_root[] = {
 	{
 		.ctl_name	= CTL_KERN,
 		.procname	= "kernel",
-		.mode		= 0755,
+		.mode		= 0555,
 		.child		= powersave_nap_ctl_table,
 	},
 	{}
