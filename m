Return-Path: <tmorrison@empirix.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: Follow up on 4 Gig of DDR on  MPC8548E
Date: Tue, 26 Jun 2007 07:11:39 -0400
Message-ID: <BD261180E6D35F4D9D32F3E44FD3D901053E84EE@EMPBEDEX.empirix.com>
References: <mailman.1956.1182519826.2671.linuxppc-dev@ozlabs.org><BD261180E6D35F4D9D32F3E44FD3D90108361D90@EMPBEDEX.empirix.com><DCEAAC0833DD314AB0B58112AD99B93B0310C3ED@ismail.innsys.innovsys.com><BD261180E6D35F4D9D32F3E44FD3D901053E84E5@EMPBEDEX.empirix.com>
	<1182814323.5521.143.camel@localhost.localdomain>
From: "Morrison, Tom" <tmorrison@empirix.com>
To: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, ltib@nongnu.org, linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> apparently after more investigations - it looks like there is =
something in the ext2 driver code
>> that is mal-adjusted....I haven't talked to the guy today who was =
looking at that - but the ext2
>> driver code that was openning a 'virtual file' / console - had some =
problems mapping that
>> space - again, my gut is telling me more stronger there is a problem =
with signed/unsigned...
>> now deeper in the ext2 code...

> I very much doubt there is a signed/unsigned issue in ext2 or =
elsewhere...
>
> You have CONFIG_HIGHMEM ? What are your setting for KERNELBASE and =
PAGE_OFFSET ?

Ben,
=20
I am sorry it I alluded to ext2 code itself having a signed/unsigned =
problem -=20
just that the problem was manifesting itself inside the ext2 code in a =
very=20
strange way ...with something that I guessed below it that was violating =

a signed/unsigned API....
=20
and I was wrong with this hunch (gotta check my hunch meter)...
It was a nuance in the configuration of inbound windows for PCI/PEX=20
that was dribbling onto the memory that was consistently being i/o =
mapped
to the ext2 driver - which then got confused and bailed completely.
=20
We now have it working as we want it to with all 4 GIG of=20
DDR working as we want it.
=20
Thank you for pushing us to push through the hunch and get to the=20
root cause. It was a tough one to find.
=20
Tom
=20
