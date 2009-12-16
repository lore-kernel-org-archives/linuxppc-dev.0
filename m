Return-Path: <bigeasy@breakpoint.cc>
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc
	[85.10.199.196])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 160C2B7093
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 17 Dec 2009 09:28:30 +1100 (EST)
Date: Wed, 16 Dec 2009 23:11:52 +0100
From: Sebastian Andrzej Siewior <bigeasy@breakpoint.cc>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: AltiVec in the kernel
Message-ID: <20091216221152.GA11248@Chamillionaire.breakpoint.cc>
References: <20091211114543.GF24650@honey.hogyros.de>
	<200912111649.25617.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
In-Reply-To: <200912111649.25617.arnd@arndb.de>
Cc: Simon Richter <Simon.Richter@hogyros.de>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

* Arnd Bergmann | 2009-12-11 16:49:25 [+0100]:

>On Friday 11 December 2009, Simon Richter wrote:
>> Hi,
>> 
>> since there has been a thread on allowing the use of a coprocessor in
>> the kernel already: I am wondering if it'd make sense to use AltiVec for
>> AES in dm-crypt, and how difficult it would be to implement that.
>> 
>> I'm using a PegasosII which has a G4 running at 1 GHz; I get around 3
>> MB/s throughput when accessing harddisks. I think that could be
>> improved.
>> 
>> If I understand correctly, the actual encryption work runs in a kernel
>> thread, which is scheduled normally, so it ought to be possible to
>> enable AltiVec for that thread; am I missing something here?

dm-crypt is async these days so the patches Arnd mentioned could be
used actually :) I've never tested them with dm-crypt but it should
work. Back then I had around 20MiB/sec encryption and around 15 MiB/sec
for decryption on 4KiB page on a PS3 [0]. This was pure testing, no
subsystem was involved. dm-crypt will feed multiple 512 byte requests.
And according [1] 512 bytes are aren't slow :) However [2] says that
that AltiVec was always slower than the generic implementation. Maybe
PS3's AltiVec unit was slower than the average one because everyone was
focuesed on the SPUs. Maybe not and you get similar results. 

>Sebastian Siewior has implemented this some time ago:
>
>http://old.nabble.com/-RFC-0-3--Experiments-with-AES-AltiVec,-part-2-tc10034255.html
>
>You can try the old patches on your machine to see if they are any good
>there.
Ah you remember :)

[0] http://diploma-thesis.siewior.net/html/diplomarbeitch4.html#x12-46002r2
[1] http://diploma-thesis.siewior.net/html/diplomarbeitch4.html#x12-46004r4
[2] http://diploma-thesis.siewior.net/html/diplomarbeitch4.html#x12-47017r5
>
>	Arnd <><

Sebastian
