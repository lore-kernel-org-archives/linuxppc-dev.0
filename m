Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18004.7556.311264.415721@cargo.ozlabs.ibm.com>
Date: Wed, 23 May 2007 20:55:00 +1000
From: Paul Mackerras <paulus@samba.org>
To: sachinp@in.ibm.com
Subject: Re: [Patch 2/2] Kexec/Kdump support - POWER6
In-Reply-To: <46540B6F.6030300@in.ibm.com>
References: <4652E088.9080207@in.ibm.com> <4652E109.4020204@in.ibm.com>
	<4652E17C.7080607@in.ibm.com> <20070522153419.GA22047@lixom.net>
	<46540B6F.6030300@in.ibm.com>
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org,
	ellerman@au1.ibm.com, Milton Miller II <miltonm@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Sachin P. Sant writes:

> On Power machines supporting VRMA, Kexec/Kdump does not work.
> Hypervisor stores VRMA mapping used by the OS, in the hpte hash
> tables. Make sure these hpte entries are left untouched.

Surely all we need to do is to avoid clearing the VRMA entries.  We
can do this by not clearing any HPTE where the top 40 bits of the
first dword are 0x4001ffffff (B=1 for a 1TB segment and the
0x0001ffffff special VSID).  In fact we can avoid having to read each
entry by doing the H_REMOVEs with H_ANDCOND and the bolted bit when we
clear the hash table, and only reading the HPTEs for which the
H_REMOVE returns an error.

Paul.
