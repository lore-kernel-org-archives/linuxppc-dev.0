Date: Wed, 24 Mar 1999 10:30:07 +0100 (MET)
From: Gabriel Paubert <paubert@iram.es>
To: Benjamin Herrenschmidt <bh40@calva.net>
cc: linuxppc-dev@lists.linuxppc.org, Paul Mackerras <paulus@cs.anu.edu.au>
Subject: Re: Blue G3 and machine check
In-Reply-To: <19990314143558.014768@mail.mipsys.com>
Message-ID: <Pine.HPP.3.96.990324094215.1078L-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




On Sun, 14 Mar 1999, Benjamin Herrenschmidt wrote:

> 
> While reading of macbsd mailing list, I've seen that the Blue G3 causes a
> machine check exception while probing a non-existing PCI slot. I don't
> have time to look into this and I don't have one of those machines, but
> if anyone want to give a try at fixing this...

In the case of a non present device, the MPC106 will terminate the cycle
with a master abort and assert both the MCP (machine check) and TEA
(transfer error)  pins. There are 2 possible quick fixes for this (can't
test them but they are very likely to work): 

 - disable the MCP and TEA pins in the MPC106: resp. bits 11 (0x800) and
10 (0x400) in the PICR1 configuration space register at offset 0xA8. 

- finer control (affects only master abort cycles) by clearing bit 1 of
ErrEnR1 at offset 0xc0. 

I don't like these solutions however because it's curing the symptom
rather than the cause (and I like to have HW error reports). AFAIR there
is code on the Alpha to handle machine checks when accessing PCI config
space, maybe it will give some ideas for a truly correct fix. 

Note that you probably only need to protect the PCI config space accesses,
for example by adding a handler to the actual accesses with code looking
like (memop may be l[bhw]z, st[bhw], l[hw]brx, st[hw]brx):

	sync
	isync
1:	memop reg,addr
2:	sync
3:	isync
4:	

(I think that at least one of the isync is probably unnecessary and
perhaps both, but I'd rather choose the safe solution for this). 
in the exception table (replace 5f by 4b for the stores):
	.long 1b,5f
	.long 2b,5f
	.long 3b,5f

and in the fixup section (for the loads only):
5:	li reg,-1
	b  4b
	 

If anybody wants to test that this works (I don't have any Mac, but I want
to enable HW error reports through machine checks on my boards in the
future). Note that you might want to encapsulate this in macros with a
name like checked_{ld,st}_{8,be16,be32,le16,le32} or in separate
subroutines to limit code expansion since it's not performance critical. 

	Regards,
	Gabriel.


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
