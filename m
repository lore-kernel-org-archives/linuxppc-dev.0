From: linas@austin.ibm.com
Date: Wed, 24 Mar 2004 11:08:14 -0600
To: Marc Leeman <marc.leeman@barco.com>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
Subject: Re: PCI Memory mapping
Message-ID: <20040324110814.E50148@forte.austin.ibm.com>
References: <20040316114030.GB7133@smtp.barco.com> <1079455175.4184.25.camel@localhost.localdomain> <20040322074833.GY7133@smtp.barco.com> <20040323111736.GJ1446@smtp.barco.com> <1080086640.23208.164.camel@gaston> <20040324122652.GA22171@smtp.barco.com> <20040324142524.GA22701@smtp.barco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20040324142524.GA22701@smtp.barco.com>; from marc.leeman@barco.com on Wed, Mar 24, 2004 at 03:25:24PM +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Mar 24, 2004 at 03:25:24PM +0100, Marc Leeman wrote:
>
> The strange thing is that this works only and only if I do a transfer
> back from kernel space into the userbuffer AFTER the DSP has
> acknowledged transferring the data. Note that this data is never used
> again. Doing this copy_to_user before DSP acknowledgement still results
> in the afore mentioned data corruption.

Excuse my total ignorance on this topic, but ... is it possible that the
DSP is using some sort of oddball bookmark mechanism to read the data?
This would be a rather poor design decision on the part of whomever
wrote the DSP code, but not out of the realms of impossible.  (I've
seen equally bizarre code in the past whose only excuse for existance
was stupidity.)  It could also be a bug in the DSP code.  The fact that
'everything is OK after DSP acks' is telling: in the end, the DSP *did*
do the right thing, by the time it ack'ed even if it did something weird
while data was flying around.

--linas

p.s. I did not read your code to see if it made sense, nor do I know
the ppc dma code.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
