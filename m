From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Henry Worth <haworth@ncal.verio.com>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: Darwin AGPGART?
Date: Fri, 20 Apr 2001 12:36:12 +0200
Message-Id: <19031231231335.5698@mailhost.mipsys.com>
In-Reply-To: <3ADF63A5.C4FC9969@ncal.verio.com>
References: <3ADF63A5.C4FC9969@ncal.verio.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>Looks like the uniNorth AGP GART finally made it into the Darwin
>CVS (xnu-4-2/iokit/Drivers/pci/drvApplePCI/AppleMacRiscPCI.[ch]
>and generic i/f defs in xnu-4-2/iokit/IOKit/pci/IOAGPDevice.h).
>Before I dig too deeply into this, has anyone looked into it
>yet?

It was there for some time ;)

I did look at it, I did also implement a driver for it, and ...
it didn't work. Basically, it looks like UniNorth AGP cannot
make the AGP aperture visible to the CPU. (It may not be the
case with all UniNorth versions, but it was on the G4 I tested
with).

That mean that some hacking similar to what the DRI driver does
for PCIGART is necessary to use it (that is doing mappings of
memory instead of mapping the AGP aperture itself).

Ben.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
