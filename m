Message-Id: <200009041751.TAA00748@piglet.grunz.lu>
Date: Mon, 4 Sep 2000 19:51:52 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: PATCH: improved processor config for G3s
To: paubert@iram.es
cc: bh40@calva.net, paulus@linuxcare.com.au, linuxppc-dev@lists.linuxppc.org
In-Reply-To: <Pine.HPX.4.10.10009041137010.15978-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On   4 Sep, this message from Gabriel Paubert echoed through cyberspace:
>> Later on, a Moto person told me there was no known grackle bug about
>> store gathering, but that the CPU ABE was needed for proper operations. I
>> also suspect that store gathering increase the effect of PCI write
>> posting, and older versions of the Adaptec drivers were not correctly
>> taking this into account on sime timing critical accesses.
>
> I'd rather take the Moto version. The problem is that store gathering
> should be inhibited if there is an eieio instruction between two
> successive stores which may be gathered. However, the eieio instruction
> is not propagated to the bus by all processors, it is by the 604 and 7400
> (and 601 IIRC), not by the 603/603e/750. I can't remember offhand if ABE
> enables eieio broadcasts on the 750, but it seems so from what Motorola
> claims.

IBM's 740/750 User's Manual states on page 2-12, in the table about ABE:

 "Affected instructions are eieio, sync, dcbi, dcbf and dcbst. A sync
 instruction completes only after a successfull broadcast. Execution of
 eieio causes a brodcast that may be used to prevent any external
 devices, such as a bus bridge chip, from store gathering"

So it seems that to prevent store gathering in bus bridges across eieio
on the 750, you need to set ABE.

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
