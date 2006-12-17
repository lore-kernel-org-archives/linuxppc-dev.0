Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] Fix sparsemem on Cell
Date: Mon, 18 Dec 2006 00:02:09 +0100
References: <20061215171411.E3EE01AD@localhost.localdomain>
In-Reply-To: <20061215171411.E3EE01AD@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200612180002.11079.arnd@arndb.de>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, hch@infradead.org,
	linux-mm@kvack.org, paulus@samba.org, mkravetz@us.ibm.com,
	gone@us.ibm.com, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 15 December 2006 18:14, Dave Hansen wrote:
> +=A0=A0=A0=A0=A0=A0=A0if (system_state >=3D SYSTEM_RUNNING)
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return 1;
> +       if (!early_pfn_valid(pfn))
> +               return 0;
> +       if (!early_pfn_in_nid(pfn, nid))
> +               return 0;

I haven't tried it, but I assume this is still wrong. On cell,
we didn't actually hit the case where the init sections have
been overwritten, since we call __add_pages from an initcall.

However, the pages we add are not part of the early_node_map,
so early_pfn_in_nid() returns a bogus result, causing some
page structs not to get initialized. I believe your patch
is going in the right direction, but it does not solve the
bug we have...

	Arnd <><
