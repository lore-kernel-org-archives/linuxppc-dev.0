Message-ID: <3FFEEAD9.80308@embeddededge.com>
Date: Fri, 09 Jan 2004 12:54:33 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: fabidi@ultsol.com
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: TLB and CSSBAR problems with MPC8540 and BDI2000
References: <704F2B356FCC3E49A909C625BD9E5C4002143D@ultsol01.tewks.ultsol.local>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Fahd Abidi wrote:

> I think my problem is all centered around TLB's and the CCSRBAR.

Yes, it is.

The debug control registers are part of the CCSRBAR space.  The
BDI2000 tracks modifications it makes if the space is moved, however,
if your software moves that space the BDI2000 doesn't know it and
can't access the registers.

If you are debugging code, like u-boot here, you have to make
several code modifications so the CCSR space isn't moved during your
debugging (among other things).


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
