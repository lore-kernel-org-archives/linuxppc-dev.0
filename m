Date: Sun, 11 Nov 2001 11:03:41 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Joseph Manojlovich <manojlov@cse.psu.edu>
Cc: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Gxt2000p Patch
In-Reply-To: <20011110185747.D28196@cardassian.cse.psu.edu>
Message-ID: <Pine.GSO.4.21.0111111102290.10838-100000@mullein.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, 10 Nov 2001, Joseph Manojlovich wrote:
> Here's the patch which I think fixes the video card issues I described
> in my last email.
>
> Joe Manojlovich
> manojlov@cse.psu.edu
>
> --- linuxppc/drivers/video/offb.c	Sat Nov 10 18:04:42 2001
> +++ offb.c	Sat Nov 10 18:43:36 2001
> @@ -393,7 +393,8 @@
>      unsigned long res_size = pitch*height*depth/8;
>
>      if (!request_mem_region(res_start, res_size, "offb"))
> -	return;
> +		if (!(dp && device_is_compatible(dp, "pci1014,b7")))
> +        	return;
>

What are the values res_start and res_size for which request_mem_region()
fails? What does /proc/iomem says?

This can only be a workaround for the problem, not a fix. The real fix is
probably a fix for the global bus resources.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
