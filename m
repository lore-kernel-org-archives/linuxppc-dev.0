Date: Mon, 3 Jun 2002 07:35:16 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: S3 trio config
Message-ID: <20020603143516.GE8193@opus.bloom.county>
References: <15608.22619.81123.994767@argo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <15608.22619.81123.994767@argo.ozlabs.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, Jun 01, 2002 at 03:15:07PM +1000, Paul Mackerras wrote:

> We have this difference between drivers/video/Config in linuxppc_2_4
> compared to the official tree:
>
> diff -urN linux-2.4.19-pre9/drivers/video/Config.in linuxppc_2_4/drivers/video/Config.in
> --- linux-2.4.19-pre9/drivers/video/Config.in	Tue May 28 22:39:29 2002
> +++ linuxppc_2_4/drivers/video/Config.in	Sat Jun  1 14:40:58 2002
> @@ -73,7 +73,7 @@
>        dep_bool '  Apple "valkyrie" display support' CONFIG_FB_VALKYRIE $CONFIG_ALL_PPC
>        bool '  Chips 65550 display support' CONFIG_FB_CT65550
>        bool '  IMS Twin Turbo display support' CONFIG_FB_IMSTT
> -      bool '  S3 Trio display support' CONFIG_FB_S3TRIO
> +      dep_bool '  S3 Trio display support' CONFIG_FB_S3TRIO $CONFIG_ALL_PPC
>        tristate '  VGA 16-color graphics console' CONFIG_FB_VGA16
>     fi
>     if [ "$CONFIG_PARISC" = "y" ]; then
>
> Does anyone know why we have this?  Is the S3 Trio display really only
> used on PReP or CHRP machines, not on any PCs?

IIRC, when I did this the S3Triofb code was full of OF'isms, so it's
really only useful on some CHRP machines.  And just checking, it's still
got:
int __init s3triofb_init(void)
{
        struct device_node *dp;

        dp = find_devices("S3Trio");
        if (dp != 0)
            s3triofb_of_init(dp);
        return 0;
}

So it certainly won't link on !CONFIG_ALL_PPC.

But more importantly, that needs to be cleaned up a bit to be more like:
if [ "$CONFIG_PPC32" = "y" ]; then
   if [ "$CONFIG_ALL_PPC" = "y" ]; then
      ... apple drivers ...
      ... S3Trio ...
   fi
   ... other drivers ...
fi

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
