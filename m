Return-Path: <cfriesen@nortel.com>
Message-ID: <4208DC74.4000107@nortel.com>
Date: Tue, 08 Feb 2005 09:36:20 -0600
From: Chris Friesen <cfriesen@nortel.com>
MIME-Version: 1.0
To: Dan Malek <dan@embeddededge.com>
References: <41FECA18.50609@nortelnetworks.com>
	<1107243398.4208.47.camel@laptopd505.fenrus.org>
	<41FFA21C.8060203@nortelnetworks.com>
	<1107273017.4208.132.camel@laptopd505.fenrus.org>
	<20050204203050.GA5889@dmt.cnet> <4203D793.1040604@nortel.com>
	<1107595148.30302.5.camel@gaston> <42077EE0.2060505@nortel.com>
	<1107812101.7734.42.camel@gaston>
	<bc4f2e60770528d4934b5a2e69285002@embeddededge.com>
In-Reply-To: <bc4f2e60770528d4934b5a2e69285002@embeddededge.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Arjan van de Ven <arjan@infradead.org>,
	Linux Kernel list <linux-kernel@vger.kernel.org>,
	linuxppc64-dev <linuxppc64-dev@ozlabs.org>
Subject: Re: question on symbol exports
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Dan Malek wrote:
> 
> On Feb 7, 2005, at 4:35 PM, Benjamin Herrenschmidt wrote:
> 
>> Interesting... more than no swap, you must also make sure you have no
>> r/w mmap'ed file (which are technically equivalent to swap).
> 
> 
> Yeah, I kinda had a similar thought.  Just because you aren't
> swapping doesn't mean the VM subsystem isn't looking at dirty bits,
> too.  It could potentially steal a page that it thinks can be replaced
> from either a zero-fill or reading again from persistent storage.

In our existing case, the app also mlock()s the pages in question.  This 
should get around these two possible sources of inaccuracy.

Chris
