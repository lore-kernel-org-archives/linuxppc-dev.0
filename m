Return-Path: <paulus@bilbo.ozlabs.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id E7C6BB70B5
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 30 Jun 2009 19:52:50 +1000 (EST)
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D4BC4DDD04
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Jun 2009 19:52:50 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <19017.57453.426119.659907@cargo.ozlabs.ibm.com>
Date: Tue, 30 Jun 2009 19:52:45 +1000
From: Paul Mackerras <paulus@samba.org>
To: kernel mailz <kernelmailz@googlemail.com>
Subject: Re: Inline Assembly queries
In-Reply-To: <abe8a1fd0906292253ye4595c9wb0c085b7d89aea7@mail.gmail.com>
References: <abe8a1fd0906271246q920124ard61422d9577e2d09@mail.gmail.com>
	<abe8a1fd0906271249k479e5a87gfe1ee9c02798a234@mail.gmail.com>
	<m3ab3t4623.fsf@google.com>
	<abe8a1fd0906272157j4246e9d3hec2e374535a22c89@mail.gmail.com>
	<abe8a1fd0906290849w1ba6bd33of60a9c2e110c10fd@mail.gmail.com>
	<m3ljna20fx.fsf@google.com>
	<abe8a1fd0906292253ye4595c9wb0c085b7d89aea7@mail.gmail.com>
Cc: gcc-help@gcc.gnu.org, linuxppc-dev@ozlabs.org,
	Ian Lance Taylor <iant@google.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

kernel mailz writes:

> Consider atomic_add and atomic_add_return in kernel code.
> I am not able to figure out why "memory" is added in latter

The "memory" indicates that gcc should not reorder accesses to memory
from one side of the asm to the other.  The reason for putting it on
the atomic ops that return a value is that they are sometimes used to
implement locks or other synchronization primitives.

Paul.
