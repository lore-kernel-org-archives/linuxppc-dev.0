Return-Path: <segher@kernel.crashing.org>
In-Reply-To: <1175219137.28116.2.camel@localhost.localdomain>
References: <1175212972.3122.87.camel@pmac.infradead.org>
	<20070330014542.GA28342@lixom.net>
	<1175219137.28116.2.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <d345e54b618b4b853cccf014b3b25589@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [Cbe-oss-dev] [PATCH] Implement check_legacy_ioport() on PS3
Date: Fri, 30 Mar 2007 15:44:02 +0200
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org,
	David Woodhouse <dwmw2@infradead.org>, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> I was thinking that we could have one single helper shared by most
> platforms who allow that legacy ISA crap which checks the device-tree
> for known ISA devices. That would cover PREP, CHRP and pSeries at
> least...

Make the helper check every device node under the ISA
node and translate the "reg" in there.  If the requested
legacy I/O region is a subset of the union of all those,
allow the access, otherwise not.  This should cover all
cases (well at least those with a valid device tree, heh).


Segher
