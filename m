Message-Id: <9903292336.AA42910@marc.watson.ibm.com>
To: Dave Weis <djweis@plconline.com>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: modifying boot loader 
In-Reply-To: Message from Dave Weis <djweis@plconline.com>
   of "Mon, 29 Mar 1999 15:48:07 CST." <Pine.LNX.3.95.990329154458.29373G-100000@catbert.desm.plconline.com>
Date: Mon, 29 Mar 1999 18:36:50 -0500
From: David Edelsohn <dje@watson.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


	What are you actually trying to accomplish?  The values at
pin_obj_start are not magic numbers or instructions but user-friendly
values mapped at address 0.  It is trying to map values 0x0 and 0XBADFCA11
(bad function call) so that dereferencing a data pointer or a PowerOpen
ABI function pointer at address zero (0) will produce a visual clue.  This
is produced by assembly like:

addr0:
       .long   0
       .long   0xBADFCA11

And you make the linker map label addr0 at physical address 0.

David

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
