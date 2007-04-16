Return-Path: <akonovalov@ru.mvista.com>
Received: from mail.dev.rtsoft.ru (unknown [85.21.88.2])
	by ozlabs.org (Postfix) with SMTP id B489ADDE3F
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 17 Apr 2007 02:47:35 +1000 (EST)
Message-ID: <4623A9AD.4020100@ru.mvista.com>
Date: Mon, 16 Apr 2007 20:51:57 +0400
From: Andrei Konovalov <akonovalov@ru.mvista.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: Mr Grant Likely's New Patches for 2.6 Kernel and Xilinx FPGA
	( Virtex-4 & Virtex-2
References: <BAY115-W1269AFE45FDEDFDEB86A99B2530@phx.gbl>	
	<528646bc0704150727p1583132ck5455a36782e4dbcc@mail.gmail.com>	
	<4623A002.7080509@ru.mvista.com>
	<528646bc0704160926i73c7976ree34564a113b3caf@mail.gmail.com>
In-Reply-To: <528646bc0704160926i73c7976ree34564a113b3caf@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Linux PPC <linuxppc-embedded@ozlabs.org>,
	Mohammad Sadegh Sadri <mamsadegh@hotmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Grant Likely wrote:
> On 4/16/07, Andrei Konovalov <akonovalov@ru.mvista.com> wrote:
>> Grant Likely wrote:
>> > No, I did not include TEMAC support.  However, I will publish my git
>> > tree tomorrow which will include the TEMAC driver.
>>
>>
>> Seems the TEMAC driver is not on your git server yet. Hence the 
>> questions.
>> Guess this is PLB TEMAC version 3.00a as you wrote auto negotiation is 
>> supported.
> 
> yup
> 
>> Is your driver based on the one by Xilinx (the one from EDK 8.2.02 and 
>> the update posted by Rick Moleres)?
> 
> Yup, it's just the adapter.c file that Rick posted plus some fixups to
> get it to compile in my tree.  Nothing really exciting.  I'm very
> interested in the phylib work that you've done.  I hope to take a look
> at that in the next day or so.

The feedback is very welcome.
Mostly was trying to use what is already in the kernel, and not to reinvent
the wheel.

I wouldn't say I've completely done with it.
Few SGDMA related ioctls to add (should be fairly straightforward).
And to check the advertised capabilities - as I wrote in the previous
posting, it looks like the driver stops advertising 1000Mbits at some
point (after turning auto negotiation off, switching to the lower speeds,
and trying to go back to 1000Mbits).

> I'm only publishing my tree as a
> convienient starting point for those who need it.
> 
> Ideally, I'd like to look at doing a full rewrite so it's in a
> condition acceptable for mainline, but I don't have time for that at
> the moment.

I am not certain if the "linux adapter plus the OS independent code"
could easily be accepted (provided that the OS independent code is
reformatted as much as possible to fit into the community).
Afraid complete rewrite is fairly large effort, and, moreover, so far PLB TEMAC
has been significantly changing from one EDK release to the next. So
one could have to rewrite considerable parts of the driver every EDK release.
Would be nice to reuse the man-hours Xilinx put in their OS indpendent code.

Thanks,
Andrei

> Cheers,
> g.
> 
