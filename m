Message-Id: <v04003a00b5602003688d@[24.66.67.194]>
In-Reply-To: <200006040709.JAA00760@piglet.grunz.lu>
References: <00060311160100.00693@enzo.bigblue.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Sun, 4 Jun 2000 10:08:39 -0500
To: mlan@cpu.lu, Franz.Sirl-kernel@lauterbach.com
From: Tony Mantler <nicoya@apia.dhs.org>
Subject: Re: [patch] VRAM detection in controlfb
Cc: linuxppc-dev@lists.linuxppc.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 2:09 AM -0500 6/4/2000, Michel Lanners wrote:
>Hi Franz,
>
>On   3 Jun, this message from Franz Sirl echoed through cyberspace:
>[hacking controlfb]
>> if you don't mind, would you try to replace the "dcbi" assembler
>>instructions
>> in the detection code with "dcbf" instructions? It seems Dan inherited
>>my bug
>> I had in the platinumfb driver...
>
>Sure, no problem.
>
>In what sense is that a bug, and what would be the symptom? I know close
>to nothing about PPC assembler, and fully understanding the detection
>code might help fix the detection problems we still have in some
>situations...

dcbi = data cache block invalidate. If you do this on a dirty cache block,
data will be lost.

dcbf = data cache block flush. If you do this on a block that isn't in a
coherent state, data will be lost.

If you have a block that's both dirty and incoherent... well, don't do that. :)


btw, my mail server messed up and I got bounced off the list a few weeks
back, have I missed anything interesting?


Cheers - Tony :)


--
Tony Mantler       Renaissance Nerd Extraordinaire     nicoya@apia.dhs.org
Winnipeg, Manitoba, Canada                     http://nicoya.feline.pp.se/


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
