Message-ID: <404837D3.3060609@imc-berlin.de>
Date: Fri, 05 Mar 2004 09:18:27 +0100
From: Steven Scholz <steven.scholz@imc-berlin.de>
MIME-Version: 1.0
To: LinuxPPC <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: uncached user space mapping with mmap() ???
References: <40473464.8010203@imc-berlin.de>
In-Reply-To: <40473464.8010203@imc-berlin.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi there,

thanks very much for all your help.
I used the stuff Stéphane suggested. But I have to ask again about
mapping of huge memory areas:

Let's say the peripheral has 32 MB address range staring at BASE. At
address GRAM 1MB of external SDRAM is located.

I use a simple test loop

	p = (unsigned short *)
		ioremap(base + GRAM, 32MB);

	START ();
	while (Retries--) {
		for (i = 0; i < Size; i++) {
			pData[i] = *p;
		}
	}
	STOP ();

When I map only the the GRAM I get a throughput of

IoremapTest...        8.0 s      => 2049.4 kW/s

But when I map the whole address range

	p = (unsigned short *)
		ioremap(BASE, imcdevif_iosize);

and move the pointer

	p += GRAM;

before entering the test loop I only get

IoremapTest...        8.4 s      => 1944.8 kW/s

How is that???

Is it always better to map only the small part I am going to use?

Thanks a million!

--
Steven Scholz

imc Measurement & Control               imc Meßsysteme GmbH
Voltastr. 5                             Voltastr. 5
13355 Berlin                            13355 Berlin
Germany                                 Deutschland


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
