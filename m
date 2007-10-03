Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18179.1934.821688.836972@cargo.ozlabs.ibm.com>
Date: Wed, 3 Oct 2007 13:07:58 +1000
From: Paul Mackerras <paulus@samba.org>
To: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH] Use 1TB segments
In-Reply-To: <20071003021105.GA6553@lixom.net>
References: <18095.59959.698141.565343@cargo.ozlabs.ibm.com>
	<1191350274.18159.279.camel@farscape.rchland.ibm.com>
	<20071003021105.GA6553@lixom.net>
Cc: linuxppc-dev@ozlabs.org, Jon Tollefson <kniht@linux.vnet.ibm.com>,
	Will Schmidt <will_schmidt@vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Olof Johansson writes:

> > This makes the kernel use 1TB segments for all kernel mappings and for
> > user addresses of 1TB and above, on machines which support them
> > (currently POWER5+ and POWER6).
> 
> PA6T supports them as well :)

In the patch, we don't actually hard-code the CPU_FTR_1T_SEGMENT bit
in the cputable entry for any processor; instead we look in the
ibm,processor-segment-sizes property in the cpu node(s) in the device
tree.  Do you want us to add the CPU_FTR_1T_SEGMENT bit to the
cputable entry for the PA6T, or will your firmware gives the
ibm,processor-segment-sizes property in the device tree?

> Wouldn't it be possible to stick with 1TB segments for the low range
> for 64-bit processes as well, and have them allocate their hugepages
> at >1TB?

You mean, forbid hugepages below 1TB?  That would be a user-visible
ABI change.  There are linker scripts for generating executables whose
text and/or data can go in hugepages, and I believe they put the
text/data below 1TB.

Paul.
