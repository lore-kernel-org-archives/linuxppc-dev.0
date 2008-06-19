Return-Path: <sanjay3000@yahoo.com>
Received: from web33101.mail.mud.yahoo.com (web33101.mail.mud.yahoo.com
	[209.191.69.131]) by ozlabs.org (Postfix) with SMTP id 6E2ADDE0D6
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Jun 2008 02:19:50 +1000 (EST)
Date: Thu, 19 Jun 2008 09:13:09 -0700 (PDT)
From: Sanjay Patel <sanjay3000@yahoo.com>
Subject: Re: [RFC 1/3] powerpc: __copy_tofrom_user tweaked for Cell
To: Arnd Bergmann <arnd@arndb.de>, Gunnar von Boehn <VONBOEHN@de.ibm.com>
In-Reply-To: <OF3C6636F6.52E3D242-ONC125746D.005214B0-C125746D.0053FABE@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <973448.15152.qm@web33101.mail.mud.yahoo.com>
Cc: Mark Nelson <markn@au1.ibm.com>, linuxppc-dev@ozlabs.org,
	Michael Ellerman <ellerman@au1.ibm.com>, cbe-oss-dev@ozlabs.org
Reply-To: sanjay3000@yahoo.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>




--- On Thu, 6/19/08, Gunnar von Boehn <VONBOEHN@de.ibm.com> wrote:

> You are right the main copy2user requires that the SRC is
> cacheable.
> IMHO because of the exception on load, the routine should
> fallback to the
> byte copy loop.
> 
> Arnd, could you verify that it works on localstore?

Since the main loops use 'dcbz', the destination must also be cacheable. IIRC, if the destination is write-through or cache-inhibited, the 'dcbz' will cause an alignment exception. I suppose it would still function correctly via the handler, but horribly slowly.

--Sanjay




      
