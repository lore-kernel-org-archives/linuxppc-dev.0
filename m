In-Reply-To: <19981214104446.A3769@bleck.ksu.ksu.edu>
Date: Thu, 17 Dec 1998 14:57:00 +0100
To: linuxppc-dev@lists.linuxppc.org, Zach Metzinger <wizkid@ksu.edu>
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: Restructure of arch/ppc/kernel and include/asm-ppc
Message-Id: <19981217145700.030398@mail.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Dec 14, 1998, Zach Metzinger <wizkid@ksu.edu> wrote:

>Anyone been hunting down the serial port problems with early g3s? Is the
>macrocell in apple's chip a true clone of the 8530 ESCC?

It should be more CHRP-like, so additional registers defined by CHRP may
be available. I'm wondering if there may be a problem like a wrong
default value in the register that indicates the number of cycles to wait
on each access. This would explain some of the problems.

Some people I know working on Geoport-based hardware had lots of troubles
with the G3 machines. It looks like quickly repeated access to the data
register will just cause corrupted datas to be transmitted. The problem
is especially visible when DMA is used. I plan to do experiments with
this but I didn't find the time yet.

-- 
           E-Mail: <mailto:bh40@calva.net>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>





[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
