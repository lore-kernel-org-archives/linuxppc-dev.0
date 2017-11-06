Return-Path: <fw@deneb.enyo.de>
Received: from albireo.enyo.de (albireo.enyo.de [5.158.152.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yW5Sz75hJzDr4J
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Nov 2017 08:35:31 +1100 (AEDT)
From: Florian Weimer <fw@deneb.enyo.de>
To: Ram Pai <linuxram@us.ibm.com>
Cc: mpe@ellerman.id.au, mingo@redhat.com, akpm@linux-foundation.org,
 corbet@lwn.net, arnd@arndb.de, linux-arch@vger.kernel.org,
 ebiederm@xmission.com, linux-doc@vger.kernel.org, x86@kernel.org,
 dave.hansen@intel.com, linux-kernel@vger.kernel.org, mhocko@kernel.org,
 linux-mm@kvack.org, paulus@samba.org, aneesh.kumar@linux.vnet.ibm.com,
 linux-kselftest@vger.kernel.org, bauerman@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, khandual@linux.vnet.ibm.com
Subject: Re: [PATCH v9 00/51] powerpc, mm: Memory Protection Keys
References: <1509958663-18737-1-git-send-email-linuxram@us.ibm.com>
Date: Mon, 06 Nov 2017 22:28:41 +0100
In-Reply-To: <1509958663-18737-1-git-send-email-linuxram@us.ibm.com> (Ram
 Pai's message of "Mon, 6 Nov 2017 00:56:52 -0800")
Message-ID: <87efpbm706.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

* Ram Pai:

> Testing:
> -------
> This patch series has passed all the protection key
> tests available in the selftest directory.The
> tests are updated to work on both x86 and powerpc.
> The selftests have passed on x86 and powerpc hardware.

How do you deal with the key reuse problem?  Is it the same as x86-64,
where it's quite easy to accidentally grant existing threads access to
a just-allocated key, either due to key reuse or a changed init_pkru
parameter?

What about siglongjmp from a signal handler?

  <https://sourceware.org/bugzilla/show_bug.cgi?id=22396>

I wonder if it's possible to fix some of these things before the exact
semantics of these interfaces are set in stone.
