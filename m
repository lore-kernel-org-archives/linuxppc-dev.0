Return-Path: <jonathan@jonmasters.org>
Received: from mailhub-node1.mailbox.net.uk (mailhub-node1.mailbox.net.uk
	[195.82.125.30]) by ozlabs.org (Postfix) with ESMTP id 672022BDB6
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  8 Oct 2004 10:13:24 +1000 (EST)
Message-ID: <4165DB83.8080001@jonmasters.org>
Date: Fri, 08 Oct 2004 01:12:51 +0100
From: Jon Masters <jonathan@jonmasters.org>
MIME-Version: 1.0
To: Tony Lee <tony.p.lee@gmail.com>
References: <000001c4aace$245a5060$6500a8c0@PortatileLG>	
	<35fb2e5904100508157a393ee2@mail.gmail.com>	
	<4162C649.6060900@ru.mvista.com>	
	<35fb2e590410051507367017a@mail.gmail.com>	
	<41641222.6080405@ru.mvista.com>
	<470b63970410071534422f6617@mail.gmail.com>
In-Reply-To: <470b63970410071534422f6617@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Andrei Konovalov <akonovalov@ru.mvista.com>, linuxppc-embedded@ozlabs.org,
	Luca Giuliani <l.giuliani@tiscali.it>
Subject: Re: Linux on Memec Virtex II Pro V4P7 Rev. 3
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Tony Lee wrote:

| I have to use the non-interrupt mode in sysace.

If necessary I will modify the quick patch I posted to use a CONFIG
option but several of us are seeing problems with interrupts - I will
change it to be the most useful for everyone, I suppose that means
making it an option.

| Jon,  what kind of performance you got from the sysace?

Crap. That's a technical term. The chip IMO has some fundamental issues
which really need to get resolved in a rev - it takes on the order of
several minutes to commit writes with a sync however we rarely have to
write to the flash and usually only store small parameter files.

| When I copy 18 MB of ace file into sysace with Linux, the
| sync command took minutes to complete for me.

Where this affects you and I is likely in writes to update the hardware
image with a new one that you have sent to the customer as a "firmware
upgrade" to be installed. It takes ages for me too - but this is a rare
enough thing that we can live with it for the moment.

| Sysace ISR should not be the issue, since there is no seeks
| and all the IO is dirven from the kernel.

The polled approach is worse IMO although I agree that there is very
little overhead in the actual ISR. Where the author went wrong (well
perhaps not wrong per se but didn't provide enough protection) was in
the unlikely case that the hardware is braindead and generates
interrupts that you didn't ask it to - the xsysace driver should also
catch interrupts when we're QUEUE_EMPTY and should not try to manipulate
an empty request queue.

Jon.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBZduDeTyyexZHHxERArI0AJ9zd7sRSnO6dZBYw/G3NpuqjNqe7wCgixC0
/eRaHY5fhfUVW7TAFRtCrQM=
=3n0G
-----END PGP SIGNATURE-----
