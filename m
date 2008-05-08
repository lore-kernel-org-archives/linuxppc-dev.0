Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18466.40594.804958.249766@cargo.ozlabs.ibm.com>
Date: Thu, 8 May 2008 16:32:50 +1000
From: Paul Mackerras <paulus@samba.org>
To: Chandru <chandru@in.ibm.com>
Subject: Re: device tree in open firmware on power6
In-Reply-To: <48229BF5.9090602@in.ibm.com>
References: <48229BF5.9090602@in.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Chandru writes:

> When I set linux 2.6.26-rc1 as default kernel to boot in 
> /etc/yaboot.conf, then the device tree in open firmware shows only one 
> memory node ( the same memory node appears in /proc/device-tree/memory@0 
> ).  But when RHEL5.2 kernel is set as default in /etc/yaboot.conf then 
> the device tree in open firmware shows plenty of memory nodes. Following 
> is the open firmware output..

Current kernels tell the firmware that they can handle having memory
represented in the /ibm,dynamic-reconfiguration-memory node, which is
a more compact representation than having it represented in multiple
/memory@xxx nodes.  Therefore firmware reports most of the memory in
the /ibm,dynamic-reconfiguration-memory node you have here:

> linux-2.6.26-rc1:
> 
> <snip>
> 0 > dev / ls
> ...
> 000000caf1b8:   /PowerPC,POWER6@6
> 000000cb0120: /memory@0
> 000000cb83d8: /ibm,dynamic-reconfiguration-memory

and only gives you one /memory@xxx node, which represents the real
memory area.  See sections C.6.2.3 and C.6.6.2 of PAPR for more
information.

Paul.
