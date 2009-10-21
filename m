Return-Path: <fweisbec@gmail.com>
Received: from mail-fx0-f221.google.com (mail-fx0-f221.google.com
	[209.85.220.221]) by ozlabs.org (Postfix) with ESMTP id 71E42B7BA3
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Oct 2009 08:21:44 +1100 (EST)
Received: by fxm21 with SMTP id 21so8101174fxm.9
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Oct 2009 14:21:42 -0700 (PDT)
Date: Wed, 21 Oct 2009 23:21:38 +0200
From: Frederic Weisbecker <fweisbec@gmail.com>
To: John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH] macintosh: Explicitly set llseek to no_llseek in ans-lcd
Message-ID: <20091021212137.GB4880@nowhere>
References: <20091010153314.827301943@linutronix.de>
	<20091010153349.966159859@linutronix.de>
	<alpine.LFD.2.00.0910212305090.3526@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.LFD.2.00.0910212305090.3526@localhost.localdomain>
Cc: Arnd Bergmann <arndbergmann@googlemail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	LKML <linux-kernel@vger.kernel.org>, linuxppc-dev@ozlabs.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@elte.hu>, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Oct 21, 2009 at 11:07:18PM +0200, John Kacur wrote:
> From 0c2b412cdccf73bdeb19bb866bfe556942eaeca2 Mon Sep 17 00:00:00 2001
> From: John Kacur <jkacur@redhat.com>
> Date: Wed, 21 Oct 2009 23:01:12 +0200
> Subject: [PATCH] macintosh: Explicitly set llseek to no_llseek in ans-lcd
> 
> Now that we've removed the BKL here, let's explicitly set lleek to no_llseek
> 
> Signed-off-by: John Kacur <jkacur@redhat.com>
> ---
>  drivers/macintosh/ans-lcd.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/macintosh/ans-lcd.c b/drivers/macintosh/ans-lcd.c
> index 4ae8ec9..a1a1bde 100644
> --- a/drivers/macintosh/ans-lcd.c
> +++ b/drivers/macintosh/ans-lcd.c
> @@ -137,6 +137,7 @@ const struct file_operations anslcd_fops = {
>  	.write		= anslcd_write,
>  	.unlocked_ioctl	= anslcd_ioctl,
>  	.open		= anslcd_open,
> +	.llseedk	= no_llseek,


llseedk? :)


Should we better pushdown default_llseek to every to every
file operations that don't implement llseek?
I don't know how many of them don't implement llseek() though.

That said we can't continue anymore with this default attribution
of default_llseek() on new fops.
