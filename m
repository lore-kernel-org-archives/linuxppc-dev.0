Return-Path: <glikely@secretlab.ca>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.30])
	by ozlabs.org (Postfix) with ESMTP id 9DF7EDDE0A
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Dec 2008 18:16:02 +1100 (EST)
Received: by yw-out-2324.google.com with SMTP id 5so379364ywh.39
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Dec 2008 23:16:00 -0800 (PST)
Message-ID: <fa686aa40812102316s165b757eva8ca282be2505964@mail.gmail.com>
Date: Thu, 11 Dec 2008 00:16:00 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
To: "Gary Thomas" <gary@mlbassoc.com>
Subject: Re: MPC5200 VIRQ question
In-Reply-To: <49406730.8040609@mlbassoc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <4937E048.90206@mlbassoc.com> <1228723422.7101.35.camel@pasglop>
	<49406730.8040609@mlbassoc.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Dec 10, 2008 at 6:04 PM, Gary Thomas <gary@mlbassoc.com> wrote:
> Benjamin Herrenschmidt wrote:
>> On Thu, 2008-12-04 at 06:51 -0700, Gary Thomas wrote:
>>> I have a MPC5200 based board which has an FPGA for external
>>> I/O, etc.  This FPGA also funnels interrupts from the various
>>> external devices through to the CPU.
>>>
>>> I've defined this structure in my DTS:
>>>
>>>      fpga@f8000000 {
>>>              device_type = "board-control";
>>>              #address-cells = <1>;
>>>              #size-cells = <1>;
>>>              // Note: includes sub-devices like CAN, A/D, etc
>>>              reg = <0xf8000000 0x100000>;
>>>
>>>              fpga_ic: fpga_ic@f8000000 {
>>>                      device_type = "fpga-int-ctlr";
>>>                      interrupt-controller;
>>>                      #address-cells = <0>;
>>>                      #interrupt-cells = <2>;
>>>                      interrupts = <2 26 3>; // IRQ2
>
> BTW, this is wrong! Are the IRQ mappings on the MPC5200 documented
> somewhere? I've looked and looked without much joy.  Only by
> experimentation did I discover that "<1 2 3>" corresponds to IRQ2.

http://www.nabble.com/-PATCH--powerpc-mpc5200:-Document-and-tidy-irq-driver-td20740376.html

This should be going in for 2.6.29.  There is also some documentation
about it in Documentation/powerpc/mpc52xx-device-tree-bindings.txt

g.
