To: Kate Alhola <kate@iti.fi>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: linuxppc_2_4_mpc5200 / 5200lite zImage continued 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Sun, 02 Nov 2003 17:31:39 +0200."
             <3FA5235B.7080007@iti.fi>
Date: Sun, 02 Nov 2003 16:55:59 +0100
Message-Id: <20031102155604.35E0AC5F59@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <3FA5235B.7080007@iti.fi> you wrote:
>
> I just fixed it by comenting out setting baudrate, then it will leave it as

This is not a good idea.

> it was after dBug. Now i get kernel booting up and initial strings
> coming out
> but kernel crashes after initMMU ( early boot prit enabled ),
> I think that i have something wrong in .config.

No. It's much more likely that you missed to pass  someother  of  the
required  information.  You  have  several options: manually set up a
bd_info structure with _all_ of the required  information;  modifying
U-Boot  so  that  you  can load and start U-Boot from RAM; installing
U-Boot into flash.

You can always get a tested and working configuration  by  performing
the standard kernel build procedure:

	bash$ make mrproper
	bash$ make icecube_5200_config
	bash$ make oldconfig
	bash$ make dep
	bash$ make uImage

[The "LITE5200" can  be  considered  identical  to  the  "IceCube"  /
"IceCube+" as far as the Linux kernel is affected.]

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Don't you know anything? I should have thought anyone knows that  who
knows anything about anything...      - Terry Pratchett, _Soul Music_

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
