Return-Path: <mita@miraclelinux.com>
Received: from mail01.miraclelinux.com (ns.miraclelinux.com [219.118.163.66])
	by ozlabs.org (Postfix) with ESMTP id BE304689F9
	for <linuxppc-dev@ozlabs.org>; Mon,  6 Feb 2006 22:53:00 +1100 (EST)
Date: Mon, 6 Feb 2006 20:52:57 +0900
To: Gabriel Paubert <paubert@iram.es>
Subject: Re: [patch 14/44] generic hweight{64,32,16,8}()
Message-ID: <20060206115257.GB11836@miraclelinux.com>
References: <20060201090224.536581000@localhost.localdomain>
	<20060201090325.905071000@localhost.localdomain>
	<20060202012637.GA25093@iram.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060202012637.GA25093@iram.es>
From: mita@miraclelinux.com (Akinobu Mita)
Cc: linux-mips@linux-mips.org, linux-m68k@vger.kernel.org,
	linux-ia64@vger.kernel.org, Ian Molton <spyro@f2s.com>,
	Balbir Singh <bsingharora@gmail.com>, Andi Kleen <ak@suse.de>,
	David Howells <dhowells@redhat.com>, linuxppc-dev@ozlabs.org,
	Greg Ungerer <gerg@uclinux.org>, sparclinux@vger.kernel.org,
	Miles Bader <uclinux-v850@lsi.nec.co.jp>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Hirokazu Takata <takata@linux-m32r.org>, linuxsh-dev@lists.sourceforge.net,
	Linus Torvalds <torvalds@osdl.org>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>, linux@horizon.com,
	Richard Henderson <rth@twiddle.net>,
	Chris Zankel <chris@zankel.net>, dev-etrax@axis.com,
	ultralinux@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxsh-shmedia-dev@lists.sourceforge.net, linux390@de.ibm.com,
	Russell King <rmk@arm.linux.org.uk>, parisc-linux@parisc-linux.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Feb 02, 2006 at 02:26:38AM +0100, Gabriel Paubert wrote:
> 
> The first step can be implemented slightly better:
> 
> unsigned int res = w-((w>>1)&0x55555555);
> 

Yes. I've got many advices about hweight speedup.


static unsigned int hweight32(unsigned int w)
{
        unsigned int res = w - ((w >> 1) & 0x55555555);
        res = (res & 0x33333333) + ((res >> 2) & 0x33333333);
        res = (res + (res >> 4)) & 0x0F0F0F0F;
        res = res + (res >> 8);
        return (res + (res >> 16)) & 0x000000FF;
}

static unsigned int hweight16(unsigned int w)
{
        unsigned int res = w - ((w >> 1) & 0x5555);
        res = (res & 0x3333) + ((res >> 2) & 0x3333);
        res = (res + (res >> 4)) & 0x0F0F;
        return (res + (res >> 8)) & 0x00FF;
}

static unsigned int hweight8(unsigned int w)
{
        unsigned int res = w - ((w >> 1) & 0x55);
        res = (res & 0x33) + ((res >> 2) & 0x33);
        return (res + (res >> 4)) & 0x0F;
}

static unsigned long hweight64(__u64 w)
{
#if BITS_PER_LONG < 64
	return hweight32((unsigned int)(w >> 32)) +
				hweight32((unsigned int)w);
#else
	__u64 res = w - ((w >> 1) & 0x5555555555555555ul);
	res = (res & 0x3333333333333333ul) + ((res >> 2) & 0x3333333333333333ul);
	res = (res + (res >> 4)) & 0x0F0F0F0F0F0F0F0Ful;
	res = res + (res >> 8);
	res = res + (res >> 16);
	return (res + (res >> 32)) & 0x00000000000000FFul;
#endif
}
