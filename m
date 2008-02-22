Return-Path: <rmcguire@videopresence.com>
Received: from smtpout10.prod.mesa1.secureserver.net
	(smtpout10-04.prod.mesa1.secureserver.net [64.202.165.238])
	by ozlabs.org (Postfix) with SMTP id F423DDDE2F
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 23 Feb 2008 10:49:57 +1100 (EST)
From: "Russell McGuire" <rmcguire@videopresence.com>
To: "'Andy Fleming'" <afleming@freescale.com>
References: <000001c87591$2b5a8740$6405a8c0@absolut>
	<E5A4895F-4CED-44C5-BFD1-9FD3E57F69CF@freescale.com>
Subject: RE: NETdev driver question xxxx_type_trans()
Date: Fri, 22 Feb 2008 15:48:51 -0800
Message-ID: <005201c875ad$7a4a97c0$6405a8c0@absolut>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <E5A4895F-4CED-44C5-BFD1-9FD3E57F69CF@freescale.com>
Cc: linuxppc-embedded@ozlabs.org
Reply-To: rmcguire@videopresence.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Andy,

Thanks... I only have the hdlc_type_trans, on the RX side of the equation.

I want the driver to be able to support two modes, so not sure if I am going
to have to put an ioctl switch into to turn this on / off. 

Mode 1) I want the driver to be able to simulate an Ethernet device, which I
assume will need to use the hdlc_type_trans(), to remove layer 2.

Mode 2) I want the driver to be able to support fully RAW mode, but then
again, perhaps the hdlc_type_trans() knows this already depending on what
mode I am setup in, via 'sethdlc' ???

At the moment before I am able to use the device, I have to configure it via

'sethdlc hdlc0 hdlc-eth' or similar. <-- that previous call I assuming links
it to the TCP/IP stack as I can assign IP addresses with 
"ifconfig hdlc0 up 192.168.1.100".

However, for true P2P support, I was wanting to be able to open the device
directly and manage everything directly at the application level, i.e. the
only protocol would be "Application Layer->HDLC" and nothing in between.

In that case, I was concerned that any removal of Layer 2 stuff, simply
would be unnecessary as the 83xx already pulls the HDLC layer stuff off,
before I get the sk_buff. <Using the MCC Engine to a TDM<T1> port>.

So not sure if the kernel will let me... But that is one of my goals.

-Russ
> -----Original Message-----
> From: Andy Fleming [mailto:afleming@freescale.com]
> Sent: Friday, February 22, 2008 12:39 PM
> To: rmcguire@videopresence.com
> Cc: linuxppc-embedded@ozlabs.org
> Subject: Re: NETdev driver question xxxx_type_trans()
> 
> 
> On Feb 22, 2008, at 14:26, Russell McGuire wrote:
> 
> > All,
> >
> > A general and specific question on the behavior of netdev devices
> > before received sk_buff(s) get passed up to the kernel.
> >
> > I am almost done creating / testing an HDLC device driver for the
> > 83xx.
> >
> >
> > I have it working at a low level and was printing out skb_bufs
> > before and after TX and RX, to ensure data integrity.
> >
> > Due to me having the print_skbbuf, AFTER the hdlc_type_trans(skb,
> > ndev).
> >
> > I thought I was continuously losing 14 bytes of data, after a
> > little digging I realized that the hdlc_type_trans() call
> >
> > was shifting the skb->data pointer forward by 14 bytes. ????????
> >
> > Is this corresponding to a 14 byte pad that the kernel stack adds
> > before it sends it down?
> >
> > And why isn't the data length being shortened as a result after I
> > call hdlc_type_trans?
> >
> > Anyway. I guess I am confused as to what this function was intended
> > for, I see there are other calls for eth_type_trans, so I imagine
> > their usage is similar.
> >
> > When are they needed?
> >
> 
> 
> They move the data pointer to point to the start of the L2 header.
> There's no need for the kernel to see the L1 header, and it doesn't
> expect it to be there when it looks at the skb.
> 
> You shouldn't be using it for TX packets.  For TX, I believe the
> kernel takes care of setting up the L1 header, though I'm not
> familiar with the kernel's hdlc support.
> 
> Andy
