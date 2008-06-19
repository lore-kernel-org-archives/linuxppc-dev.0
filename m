Return-Path: <markn@au1.ibm.com>
From: Mark Nelson <markn@au1.ibm.com>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC 0/3] powerpc: memory copy routines tweaked for Cell
Date: Fri, 20 Jun 2008 09:49:29 +1000
References: <200806191753.51495.markn@au1.ibm.com>
	<200806191353.17323.arnd@arndb.de>
In-Reply-To: <200806191353.17323.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200806200949.29673.markn@au1.ibm.com>
Cc: linuxppc-dev@ozlabs.org, Gunnar von Boehn <VONBOEHN@de.ibm.com>,
	cbe-oss-dev@ozlabs.org, Michael Ellerman <ellerman@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 19 Jun 2008 09:53:16 pm Arnd Bergmann wrote:
> On Thursday 19 June 2008, Mark Nelson wrote:
> > The plan is to use Michael Ellerman's code patching work so that at runtime
> > if we're running on a Cell machine the new routines are called but otherwise
> > the existing memory copy routines are used.
> 
> Have you tried running this code on other platforms to see if it
> actually performs worse on any of them? I would guess that the
> older code also doesn't work too well on Power 5 and Power 6, so the
> cell optimized version could give us a significant advantage as well,
> albeit less than another CPU specific version.
> 
> 	Arnd <><
> 

I did run the tests on Power 5 and Power 6, and on Power 5 with the
new routines, the iperf bandwidth increased to 7.9 GBits/sec up from
7.5 GBits/sec; but on Power 6 the bandwidth with the old routines
was 13.6 GBits/sec compared to 12.8 GBits/sec...

I also couldn't get the updated routines to boot on 970MP without
removing the dcbz instructions.

I'll investigate more and also rerun the tests again

Thanks!

Mark
