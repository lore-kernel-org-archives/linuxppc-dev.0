Return-Path: <blofeldus@yahoo.com>
Received: from web53510.mail.yahoo.com (web53510.mail.yahoo.com
	[206.190.37.71]) by ozlabs.org (Postfix) with SMTP id 8383A2BEA0
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 17 Nov 2004 08:28:16 +1100 (EST)
Message-ID: <20041116212814.592.qmail@web53510.mail.yahoo.com>
Date: Tue, 16 Nov 2004 13:28:13 -0800 (PST)
From: roger blofeld <blofeldus@yahoo.com>
To: Dale Farnsworth <dale@farnsworth.org>
In-Reply-To: <20041116201654.GA3088@xyzzy>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Lite5200 FEC Driver on linux 2.6 broken? (again)
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--- Dale Farnsworth <dale@farnsworth.org> wrote:

> On Tue, Nov 16, 2004 at 10:26:09AM -0800, roger blofeld wrote:
> > Retransmissions from the lite5200 work OK now, but the occasional
> ACK
> > packet is sent from the lite5200 with a bad checksum causing
> > retransmissions. Perhaps another patch would fix this problem too?
> 
> I too have seen occasional errors, but I don't think it's a software
> issue.
> 
> -Dale
> 
One more clue to what is happening: Whenever a packet is transmitted
with a bad checksum, the tail end of the data is in error. For example,
a packet of 0x442 bytes (0x42 header, 0x400 data) is corrupt from byte
0x360 on. Corruption always happens at a multiple of 0x10 from the
start of the packet. If it is software, perhaps we don't wait long
enough for DMA completion, or DMA signals completion too soon? Or maybe
the buffer is re-used or stomped on? Seems like too large of a
corruption to be due to cache.
-roger


		
__________________________________ 
Do you Yahoo!? 
The all-new My Yahoo! - Get yours free! 
http://my.yahoo.com 
 
