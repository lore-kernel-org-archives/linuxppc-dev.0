Return-Path: <dwh@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.ovro.caltech.edu",
	Issuer "mail.ovro.caltech.edu" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 3F6D0DDDFD
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 24 Aug 2007 02:34:03 +1000 (EST)
Message-ID: <46CDB6B7.4040907@ovro.caltech.edu>
Date: Thu, 23 Aug 2007 09:32:55 -0700
From: David Hawkins <dwh@ovro.caltech.edu>
MIME-Version: 1.0
To: Mirek23 <miroslaw.dach@psi.ch>
Subject: Re: signals handling in the kernel
References: <12032525.post@talk.nabble.com>
	<46B8A3C9.7060806@ovro.caltech.edu>	<46B8BA93.8020909@ovro.caltech.edu>
	<12234438.post@talk.nabble.com>	<46C9C70D.9080903@ovro.caltech.edu>
	<12291367.post@talk.nabble.com>
In-Reply-To: <12291367.post@talk.nabble.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Mirek,

> Thank you for your hints. I was not aware about race
> conditions in signal handling routines. So far I did
> not noticed any anomalies when running my server
> since I use only one interrupt which refers to only one
> signal. I would be interested however in the solution
> you have suggested with: SIGIO and fasync() 
> 
> Would you be so kind to provide me with some example code.

Look at simple_driver.c and simple_driver_test.c in

http://www.ovro.caltech.edu/~dwh/correlator/software/driver_design.tar.gz
http://www.ovro.caltech.edu/~dwh/correlator/cobra_docs.html

Note that I used the old signals API in the user-space test:

    /* Connect up the signal handler */
    signal(SIGIO, &sigio_handler);

But you should really use the new signals API. I can't
remember the reason, it'll be explained in the Robbins&Robbins
book I reference below.

Note that another issue with signals is that they are
not queued. So if you have multiple events, you might
miss one.

I found a reference to unreliable signals. Take a look
at the signals chapter in "Advanced Programming in the Unix
Environment", by Stevens. However, that book is a bit old
now. The lack of safety may now only apply to that specific
signals API.

Another nice book is "Unix Systems Programming", by Robbins
and Robbins. Look in Chapter 8. Especially Section 8.6. That
section discusses the problems you'll face when your signal
interrupts POSIX calls, and functions that are signal handler
safe.

These types of issues would not be faced using select().
Hence the reason I can't remember the details on using
signals; as I rarely use them. The exception is that I
do catch ctrl-C to then shut down a process cleanly.
However, most of my user-space code is written using the
ACE C++ classes and infra-structure, and in that case you
deal with signals by creating an event handler, and
registering it with a reactor, which is implemented with,
you guessed it, select().  Notice the theme ... :)

The ACE C++ libraries are detailed in: "C++ Network
Programming" Volume 1 & 2 by Huston and Schmidt, and
in "The ACE programmers guide", by Huston et al.

Cheers,
Dave
