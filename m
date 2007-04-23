Return-Path: <linas@austin.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 413E6DDF01
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Apr 2007 08:36:14 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l3NMa1fc018789
	for <linuxppc-dev@ozlabs.org>; Mon, 23 Apr 2007 18:36:01 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l3NMa0hF073882
	for <linuxppc-dev@ozlabs.org>; Mon, 23 Apr 2007 16:36:00 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l3NMa07M024169
	for <linuxppc-dev@ozlabs.org>; Mon, 23 Apr 2007 16:36:00 -0600
Date: Mon, 23 Apr 2007 17:35:59 -0500
To: David Huffman <dhuffman@storix.com>
Subject: Re: Kernel Panic booting cdrom
Message-ID: <20070423223559.GT31947@austin.ibm.com>
References: <46202254.1090606@storix.com> <20070414044529.GE6062@localdomain>
	<4623F574.1030804@storix.com> <20070417054537.GF6062@localdomain>
	<46292B07.3030907@storix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <46292B07.3030907@storix.com>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: linuxppc-dev@ozlabs.org, Nathan Lynch <ntl@pobox.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Apr 20, 2007 at 02:05:11PM -0700, David Huffman wrote:
> there may be power and cooling daemons that are not running and try to 
> limit the system resources by limiting the number of cpus. Does this 
> sound right? 

As Michael Ellerman points out, the answer is no.
The idle loop specifically uses instructions that put the
cpu into low-power mode. If you don't call the idle loop, the 
cpu probably won't go into low-power mode!

> The maxcpus=1 argument was something we added to our install boot 
> media years ago and few here remember why it was such a great idea. The 
> power/resource management was the only thing we could come up with.

Ooh, this is worthy of tatooing onto a cluestick.

--linas
