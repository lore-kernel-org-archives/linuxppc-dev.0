Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18390.9137.626123.104628@cargo.ozlabs.ibm.com>
Date: Tue, 11 Mar 2008 17:16:17 +1100
From: Paul Mackerras <paulus@samba.org>
To: Manish Ahuja <ahuja@austin.ibm.com>
Subject: Re: [PATCH 3/8] pseries: phyp dump: use sysfs to release reserved mem
In-Reply-To: <47C75189.4070801@austin.ibm.com>
References: <47B90F55.2080606@austin.ibm.com>
	<1203641584.15378.2.camel@concordia.ozlabs.ibm.com>
	<47C74A66.1060105@austin.ibm.com> <47C75189.4070801@austin.ibm.com>
Cc: linuxppc-dev@ozlabs.org, linasvepstas@gmail.com, mahuja@us.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Manish Ahuja writes:

> Check to see if there actually is data from a previously
> crashed kernel waiting. If so, Allow user-sapce tools to
> grab the data (by reading /proc/kcore). When user-space 
> finishes dumping a section, it must release that memory
> by writing to sysfs. For example,
> 
>   echo "0x40000000 0x10000000" > /sys/kernel/release_region
> 
> will release 256MB starting at the 1GB.  The released memory
> becomes free for general use.
> 
> Signed-off-by: Linas Vepstas <linasvepstas@gmail.com>
> Signed-off-by: Manish Ahuja <mahuja@us.ibm.com>
> 
> ------

This line needs to be exactly 3 dashes, because otherwise the tools
include the diffstat into the commit message.  Putting 4 or more
dashes was an annoying habit Linas had, and it means I have to fix it
manually (usually after I have committed the patches, and then notice
that the commit message has the extra stuff in it, so I have to go
back and fix the separators, reset my tree and re-commit the patches.)

> +		dump_header = of_get_property(rtas, "ibm,kernel-dump",
> +								&header_len);

This is a somewhat weird-looking way of coping with too-long lines.
Please indent the second line either one more tab than the first line,
or else so that it starts just after the '(' in the first line (which
is what emacs will do by default).  The same comment applies in
several other places.

Paul.
