Return-Path: <matej.kupljen@ultra.si>
Received: from deliver-2.mx.triera.net (deliver-2.mx.triera.net [213.161.0.32])
	by ozlabs.org (Postfix) with ESMTP id E395A67B32
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 26 Jul 2006 19:30:48 +1000 (EST)
Subject: Re: Slow boot with NFS, server not responding
From: Matej Kupljen <matej.kupljen@ultra.si>
To: Edward Jubenville <edjubenville@adelphia.net>
In-Reply-To: <GPECLCIGPLHEOMGPMCPAOEIIDNAA.edjubenville@adelphia.net>
References: <GPECLCIGPLHEOMGPMCPAOEIIDNAA.edjubenville@adelphia.net>
Content-Type: text/plain
Date: Wed, 26 Jul 2006 11:03:19 +0200
Message-Id: <1153904599.7133.21.camel@localhost.localdomain>
Mime-Version: 1.0
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

Hi 

> I am having trouble booting the kernel with a root file system over NFS.
> Once the kernel has mounted the file system, it cycles through this pair of
> messages, endlessly:
> 
> 	nfs: server 192.168.0.39 not responding, still trying
> 	nfs: server 192.168.0.39 OK

We had the same problems on a DBAU1200 board, because that board uses
smc91c111 chip, which has small RX buffers, and a lot of RX overruns
happened.

We solved this by specifying additional kernel command line parameter:
nfsroot=,tcp
which specifies that for the NFS TCP should be used instead of UDP.

I hope this helps.

BR,
Matej
