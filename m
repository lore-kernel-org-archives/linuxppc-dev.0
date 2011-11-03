Return-Path: <segher@kernel.crashing.org>
In-Reply-To: <2DD52030B5146141BEB762A11AE97C4C0100C4AA@SPQCEXC05.exfo.com>
References: <2DD52030B5146141BEB762A11AE97C4C0100C4AA@SPQCEXC05.exfo.com>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <E084F63F-C294-471C-AEFB-EBF5F8CCA89E@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: fpga driver on custom PPC target platform (P4080) ...
Date: Thu, 3 Nov 2011 22:22:13 +0100
To: Robert Sciuk <robert.sciuk@exfo.com>
Cc: devicetree-discuss@lists.ozlabs.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> 	- How does one specify in the device tree an FPGA which uses
> both I2c bus and localbus for programming?

You have two device nodes, one on the localbus and one on the IIC bus.
One of the nodes points to the other, or both do; you point to another
node by having a property containing the phandle of that other node.

It's probably easiest to make the IIC node point to the localbus node,
because you will most likely always have exactly one of those, and you
could have multiple IIC nodes on your FPGA, or none at all.  But this
is something you'll have to put in the device binding for your device,
and it doesn't really matter what you choose -- it will work either way,
some choices are more convenient than others though.


Segher
