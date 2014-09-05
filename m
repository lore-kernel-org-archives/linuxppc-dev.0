Return-Path: <peter@hurleysoftware.com>
Received: from n23.mail01.mtsvc.net (mailout32.mail01.mtsvc.net [216.70.64.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B12B51A001C
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Sep 2014 05:24:46 +1000 (EST)
Message-ID: <540A0DF3.8030802@hurleysoftware.com>
Date: Fri, 05 Sep 2014 15:24:35 -0400
From: Peter Hurley <peter@hurleysoftware.com>
MIME-Version: 1.0
To: paulmck@linux.vnet.ibm.com
Subject: Re: bit fields && data tearing
References: <54079B70.4050200@hurleysoftware.com>
 <1409785893.30640.118.camel@pasglop>
 <063D6719AE5E284EB5DD2968C1650D6D17487172@AcuExch.aculab.com>
 <1409824374.4246.62.camel@pasglop> <5408E458.3@zytor.com>
 <54090AF4.7060406@hurleysoftware.com> <54091B30.2090509@zytor.com>
 <20140905081648.GB5281@omega> <20140905180950.GU5001@linux.vnet.ibm.com>
 <540A05F7.1070202@hurleysoftware.com>
 <20140905190506.GV5001@linux.vnet.ibm.com>
In-Reply-To: <20140905190506.GV5001@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Cc: Jakub Jelinek <jakub@redhat.com>,
 "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
 Tony Luck <tony.luck@intel.com>,
 "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
 Michael Cree <mcree@orcon.net.nz>, linux-alpha@vger.kernel.org,
 Oleg Nesterov <oleg@redhat.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 David Laight <David.Laight@ACULAB.COM>, Paul Mackerras <paulus@samba.org>,
 "H. Peter Anvin" <hpa@zytor.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Miroslav Franc <mfranc@redhat.com>, Richard Henderson <rth@twiddle.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/05/2014 03:05 PM, Paul E. McKenney wrote:
> On Fri, Sep 05, 2014 at 02:50:31PM -0400, Peter Hurley wrote:
>> On 09/05/2014 02:09 PM, Paul E. McKenney wrote:

[cut]

>>> ------------------------------------------------------------------------
>>>
>>> documentation: Record limitations of bitfields and small variables
>>>
>>> This commit documents the fact that it is not safe to use bitfields as
>>> shared variables in synchronization algorithms.  It also documents that
>>> CPUs must provide one-byte and two-byte load and store instructions
>>                    ^
>>                 atomic
> 
> Here you meant non-atomic?  My guess is that you are referring to the
> fact that you could emulate a one-byte store on pre-EV56 Alpha CPUs
> using the ll and sc atomic-read-modify-write instructions, correct?

Yes, that's what I meant. I must be tired and am misreading the commit
message, or misinterpreting it's meaning.
