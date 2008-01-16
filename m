Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18317.34394.863315.83309@cargo.ozlabs.ibm.com>
Date: Wed, 16 Jan 2008 15:21:46 +1100
From: Paul Mackerras <paulus@samba.org>
To: Manish Ahuja <ahuja@austin.ibm.com>
Subject: Re: [PATCH 3/8] pseries: phyp dump: reserve-release proof-of-concept
In-Reply-To: <4782C2FB.7020105@austin.ibm.com>
References: <4782B985.2090508@austin.ibm.com> <4782C2FB.7020105@austin.ibm.com>
Cc: mahuja@us.ibm.com, linuxppc-dev@ozlabs.org, linasvepstas@gmail.com,
	lkessler@us.ibm.com, strosake@us.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Manish Ahuja writes:

> Initial patch for reserving memory in early boot, and freeing it later.
> If the previous boot had ended with a crash, the reserved memory would contain
> a copy of the crashed kernel data.

The main problem I see here is that if this option is turned on, the
kernel now has only 256MB of memory from early boot until
subsys_initcalls are done -- on any machine, and whether or not there
is actually a dump.  That means, for instance, that a machine running
bare-metal (such as a G5) might not be able to allocate the hash table
for the MMU.  Also, any allocations made during that time won't be
able to be node-local.

So it will be necessary to read the flattened device tree early on to
see whether or not there is a dump, so that we don't reserve most of
memory in the cases where there isn't a dump.

Paul.
