To: Marc Leeman <marc.leeman@barco.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: memory dump 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 24 May 2004 13:27:45 +0200."
             <20040524112745.GV23093@smtp.barco.com>
Date: Mon, 24 May 2004 20:03:07 +0200
Message-Id: <20040524180312.70E5FC109F@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <20040524112745.GV23093@smtp.barco.com> you wrote:
>
>
> Can I obtain the memory location of kernel variables based on the
> System.map file in such a way that I can dump them with a BDI probe.

Yes. Just "grep" for the symbol in System.map and subtract KERNELLOAD
resp. CONFIG_KERNEL_START (0xC0000000); for example:

	-> grep log_buf System.map
	c017c754 b log_buf

Use: "dump 0x0017c754" to dump the contents of the log buffer.

See also http://www.denx.de/twiki/bin/view/DULG/LinuxPostMortemAnalysis

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"The glory of creation is in its infinite diversity." "And in the way
our differences combine to create meaning and beauty."
	-- Dr. Miranda Jones and Spock, "Is There in Truth No Beauty?",
	   stardate 5630.8

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
