Return-Path: <dan@embeddedalley.com>
Received: from smtp103.biz.mail.re2.yahoo.com (smtp103.biz.mail.re2.yahoo.com
	[68.142.229.217]) by ozlabs.org (Postfix) with SMTP id F0A2A67B44
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  8 Jun 2006 02:34:24 +1000 (EST)
In-Reply-To: <200606071434.08905.laurent.pinchart@tbox.biz>
References: <200606071434.08905.laurent.pinchart@tbox.biz>
Mime-Version: 1.0 (Apple Message framework v750)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <B2526A5D-F9F5-4E79-9003-46B9803971D9@embeddedalley.com>
From: Dan Malek <dan@embeddedalley.com>
Subject: Re: CPM_UART should allocate DPRAM for SMCx parameter RAM on MPC82xx
Date: Wed, 7 Jun 2006 12:34:27 -0400
To: Laurent Pinchart <laurent.pinchart@tbox.biz>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Jun 7, 2006, at 8:34 AM, Laurent Pinchart wrote:

> I'm not sure how to fix the problem

They way this _used_ to work is the DPRAM memory allocator
knew the SMCs had allocated the lower 128 bytes of DPRAM and
it never would allocate this space to anyone else (and it should not
free it either).  The constant #defined values for the SMC base
address would work just fine and could be assigned as part of
the SMC uart initialization.  Due to the alignment restrictions and
no reason to relocate this space anywhere else, this still seems
to be the most efficient method.


	-- Dan
