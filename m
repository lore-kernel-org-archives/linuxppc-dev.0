In-Reply-To: <DCEAAC0833DD314AB0B58112AD99B93B06DAF9@ismail.innsys.innovsys.com>
References: <DCEAAC0833DD314AB0B58112AD99B93B06DAF9@ismail.innsys.innovsys.com>
Mime-Version: 1.0 (Apple Message framework v618)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <8A97AC03-BB07-11D8-A55A-003065F9B7DC@embeddededge.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>
From: Dan Malek <dan@embeddededge.com>
Subject: Re: Poor 8260 FCC Ethernet performance 
Date: Thu, 10 Jun 2004 13:56:47 -0400
To: "Rune Torgersen" <runet@innovsys.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Jun 9, 2004, at 6:33 PM, Rune Torgersen wrote:

>
> BTW, found the problem with that piece of code about 2 seconds after
> sending it....
> The fcc_rbase &tbase parameters are not given the physical address, but
> the virtual one...

What?  No, no no.

You must not use pa() on immap addresses.  All you did was convert
a proper address to some bogus one, you are writing over some other
part of memory that is eventually going to cause a failure.  The immap
addresses are identity mapped virtual to physical.

There isn't any performance problem  with this driver if your hardware
is working properly.  I cant' believe this change would have done
anything except eventually causing the system to fail.

What kernel are you using?

Thanks.

	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
