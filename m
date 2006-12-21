Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.177]) by ozlabs.org (Postfix) with ESMTP id 32E49DDEBF
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Dec 2006 11:11:34 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [patch 0/1] updated version
Date: Thu, 21 Dec 2006 01:11:27 +0100
References: <20061218163846.337fed65@localhost> <45882913.2000609@acm.org>
	<20061220154517.6341fce6@localhost>
In-Reply-To: <20061220154517.6341fce6@localhost>
MIME-Version: 1.0
Message-Id: <200612210111.28186.arnd@arndb.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Cc: Christian Krafft <krafft@de.ibm.com>,
	openipmi-developer@lists.sourceforge.net,
	Christian Krafft <krafft@linux.vnet.ibm.com>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 20 December 2006 15:45, Christian Krafft wrote:
> I'm about to send an updated version,
> 
> I added 
> length check for the properties,
> DEFAULT_REGSIZE,
> simplified the comparison,
> 
> I did not fix the compiler warning.
> 

You should really fix the warning before sending the patch, ideally
you also check that you don't introduce new warnings found by 'sparse'.

Is the warning just about the cast from void* to enum? If so, you
need to replace that with a cast to unsigned long, like

enum { A, B, } e;
void *p;

p = (void *)(unsigned long)A;
e = (unsigned long)p;

	Arnd <><
