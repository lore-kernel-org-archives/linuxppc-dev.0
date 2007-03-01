Return-Path: <devtty0@gmail.com>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.186])
	by ozlabs.org (Postfix) with ESMTP id 31023DDEEE
	for <linuxppc-dev@ozlabs.org>; Thu,  1 Mar 2007 20:29:09 +1100 (EST)
Received: by nf-out-0910.google.com with SMTP id m18so757089nfc
	for <linuxppc-dev@ozlabs.org>; Thu, 01 Mar 2007 01:29:07 -0800 (PST)
Message-ID: <45E69CDF.20608@gmail.com>
Date: Thu, 01 Mar 2007 10:29:03 +0100
From: Luotao Fu <devtty0@gmail.com>
MIME-Version: 1.0
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: problems with pci bus on a pm520 board
References: <45E5ED35.7090207@gmail.com>
	<0a1927a91e52d34352e8a545b7dc57d0@kernel.crashing.org>
	<45E61161.9040900@gmail.com>
	<eaa8f5754d3e1544ce91df01acf2054d@kernel.crashing.org>
In-Reply-To: <eaa8f5754d3e1544ce91df01acf2054d@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

Segher Boessenkool wrote:

> You removed the original copyright notice, please don't;
> it might even be illegal to do so, depending on where
> you live/work.  Just add your own, don't remove the original.
> 

OK, thanx for the hint.

>>             interrupt-map = <8000 0 0 1 500 1 1 3 // e100, 10.0
>>                              8000 0 0 2 500 1 1 3
>>                              8000 0 0 3 500 1 1 3
>>                              8000 0 0 4 500 1 1 3
> 
> 8000 is device 16, not 10
> 
>>                              8800 0 0 1 500 1 0 3 // usb 11.0, 11.1, 11.2
>>                              8800 0 0 2 500 1 2 3
>>                              8800 0 0 3 500 1 3 3
>>                              8800 0 0 4 500 0 0 3>;
> 
> and 8800 is device 17
> 

Hmm, this is strange. I put some debug printks in the of parser
prom_parser.c in the function of_irq_map_raw somewhere in the machting
loop, which prints the imap and address being parsed. So that the lines
at about 834 now looks like this:
match = 1;
for (i = 0; i < addrsize && match; ++i) {
<snip>
	printk(" -> imap %x addr %x mask %x\n", imap[i], addr[i], mask);
}
for (; i < (addrsize + intsize) && match; ++i) {
<snip>
	printk(" -> imap %x intspec %x mask %x\n", imap[i],
intspec[i-addrsize], mask);
}
<snip>
printk(" -> match=%d (imaplen=%d), addr %d \n", match, imaplen, addr[i]);

With these printks I got for example for device 10.0 the output

Try to map irq for 0000:00:10.0...
        PCI: pdev bus number: 0, devfn: 128
of_irq_map_raw: par=/soc5200@f0000000/pci@0d00,intspec=[0x00000001
0x00008000...],ointsize=1
of_irq_map_raw: ipar=/soc5200@f0000000/pci@0d00, size=1
 -> imap 8000 addr 8000 mask f800
 -> imap 0 addr 0 mask 0
 -> imap 0 addr 0 mask 0
 -> imap 1 intspec 1 mask 7
 -> match=1 (imaplen=60), addr 1
 -> newintsize=3, newaddrsize=0
 -> imaplen=56
 -> new parent: /soc5200@f0000000/pic@500
 -> got it !
 -> got one, spec 3 cells (0x00000001...) on /soc5200@f0000000/pic@500
 -> virq :65

As I have noticed, the array addr is filled in of_irq_map_pci() by
laddr[0] = (pdev->bus->number << 16) | (pdev->devfn << 8);
Since my pdev->bus->number is 0. I got the address 8000 here. Is the
pdev->bus->number actually supposed to be 10 for device 10? I had some
trouble tracking down how the bus number is initialized. It might be
nice if you or some one could give me a hint on this.


Thanx again
cheers
Luotao Fu
