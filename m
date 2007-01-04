Return-Path: <benh@kernel.crashing.org>
Subject: Re: [PATCH 1/1] determine last ext3 LBA to fix wild LBA reads - v2
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Doug Maxey <dwm@enoyolf.org>
In-Reply-To: <32402.1167876681@bebe.enoyolf.org>
References: <32361.1167808666@bebe.enoyolf.org>
	<1167872956.6165.172.camel@localhost.localdomain>
	<32402.1167876681@bebe.enoyolf.org>
Content-Type: text/plain
Date: Thu, 04 Jan 2007 14:31:10 +1100
Message-Id: <1167881470.6165.191.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: yaboot-devel@ozlabs.org, Linux PowerPC List <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2007-01-03 at 20:11 -0600, Doug Maxey wrote:
> On Thu, 04 Jan 2007 12:09:16 +1100, Benjamin Herrenschmidt wrote:
> > >       tempb = (((unsigned long long) block) *
> > >  	      ((unsigned long long)bs)) + (unsigned long long)doff;
> > > +     if (tempb > dend) {
> > > +	  DEBUG_F("\nSeek error on block %lx, tempb=%Lx\n", block, tempb >> 9);
> > > +	  return EXT2_ET_LLSEEK_FAILED;
> > > +     }
> > > +
> > 
> > In the case where we don't pass a "part", dend is 0 no ? We should check
> > this case and not apply the test...
> 
> well, I guess we should not test in that case.  (dend && tempb >> dend)
> But that puts us back in the position of searching past the end of the 
> disk.
> 
> On what system would we get here without having found a partition table?
> Ext2 on a optical disk?

Or if you explicitely pass something like hd:0,\xxxx I suppose and it
detects it as ext2... I don't remember for sure :-)

Ben.
