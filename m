To: "Robert P. J. Day" <rpjday@mindspring.com>
Cc: Embedded Linux PPC list <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: loading the kernel and root FS separately from flash? 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Sun, 27 Jun 2004 18:46:20 EDT."
             <Pine.LNX.4.60.0406271836300.10210@localhost.localdomain>
Date: Mon, 28 Jun 2004 09:09:11 +0200
Message-Id: <20040628070916.706A6C109F@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <Pine.LNX.4.60.0406271836300.10210@localhost.localdomain> you wrote:
>
>    with this configuration, it's obviously not possible to update files
> or directories in the bootable image individually -- it's just one big
> zImage.inited image.

What makes you think that this is not  possible?  If  there  is  (for
example)  a  writable JFFS2 partition available, you can use this for
an overlay filesystem to store the updates.

See for example the "mini_fo" overlay filesystem on  our  FTP  server
and the paper about it:
http://www.denx.de/PDF/Diplomarbeit-MK-1.0-net.pdf

>    but is it feasible to redefine the layout of that flash chip and
> take, say, 4M of it and create a JFFS2 filesystem, then put the root
> filesystem in there uncompressed?  (assuming, of course, that the

Standard JFFS2 code will always compress.

>    is this possible?  anyone done it this way, and can tell me what
> pitfalls i have to watch for?  thanks.

This is a pretty standard setup. Although I don't really recommend to
use JFFS2 for root filesystem (for example, because with a  big  root
filesystem  the boot time may deteriorate). Instead, we usually split
the stuff in a read-only partition (for example cramfs),  a  volatile
part (tmpfs), and a persistent storage partition (JFFS2).

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Generally speaking, there are other ways to accomplish whatever it is
that you think you need ...                               - Doug Gwyn

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
