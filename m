Return-Path: <akonovalov@ru.mvista.com>
Received: from mail.dev.rtsoft.ru (unknown [85.21.88.2])
	by ozlabs.org (Postfix) with SMTP id CE7E8DDEF5
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 16 May 2007 04:02:23 +1000 (EST)
Message-ID: <4649F6FF.7060003@ru.mvista.com>
Date: Tue, 15 May 2007 22:07:59 +0400
From: Andrei Konovalov <akonovalov@ru.mvista.com>
MIME-Version: 1.0
To: Miroslaw Dach <miroslaw.dach@psi.ch>
Subject: Re: zImage.elf loads but does not start
References: <Pine.LNX.4.44.0705151430120.7758-100000@slslc02.psi.ch>
In-Reply-To: <Pine.LNX.4.44.0705151430120.7758-100000@slslc02.psi.ch>
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

Miroslaw Dach wrote:
>>> [    9.357642] Freeing unused kernel memory: 96k init
>> Any NFS timeouts after reaching this point? Any network activity at all?
>> (NFS timeout is quite long, so waiting few minutes would make sense)
> 
> I have monitored the network activity on the NFS server with program
> ethereal. It seems to be that the root file system is mounted. There are
> packet sent from a to my xilinx board. The /var/log/messages contains also
> the entry that mount was done successfully. When init is executed the
> ethereal show only individual packets which are sent (in fixed interval of
> time - once per 20 seconds) from the NFS server to the client but client
> seem to be dead. Even ping does not reach my xilinx board when kernel
> executes the init.

Hmm...
IIRC TEMAC is configured in FIFO mode.
And I thought the problem could be due to small FIFOs. So that the default
NFS reply of 4kbytes could not fit into the receive FIFO, and the CPU is not
fast enough to read the reply out of the FIFO before it overflows.
But your observations don't seem to confirm this is the case.

Anyway, you could try adding
   nfsroot=,rsize=1024,wsize=1024
to your cmdline just in case...

Thanks,
Andrei

> I think that the best prove that the rootfile system is properly mounted
> is the fact that my own test init function (which substitutes the real
> init) which simply prints the string to the console does that what is
> expected to do. The real init unfortunately does not print anything to the 
> console.
> 
> Best Regards
> 
> Mirek
> 
