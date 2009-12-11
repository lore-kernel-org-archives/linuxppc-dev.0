Return-Path: <glikely@secretlab.ca>
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <200912071508.25551.jeremy.kerr@canonical.com>
References: <20091124081316.6216.66310.stgit@angua>
	<20091124081853.6216.68105.stgit@angua>
	<200912071508.25551.jeremy.kerr@canonical.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Thu, 10 Dec 2009 23:20:09 -0700
Message-ID: <fa686aa40912102220r45ecf9ael66f504e39c55cfa1@mail.gmail.com>
Subject: Re: [PATCH 06/11] of/flattree: merge early_init_devtree() and
	early_init_move_devtree()
To: Jeremy Kerr <jeremy.kerr@canonical.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: sfr@canb.auug.org.au, monstr@monstr.eu, microblaze-uclinux@itee.uq.edu.au,
	devicetree-discuss@lists.ozlabs.org, sparclinux@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, davem@davemloft.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Dec 7, 2009 at 12:08 AM, Jeremy Kerr <jeremy.kerr@canonical.com> wr=
ote:
> Hi Grant,
>
>> + =A0 =A0 /* Scan memory nodes and rebuild LMBs */
>> + =A0 =A0 lmb_init();
>> + =A0 =A0 of_scan_flat_dt(early_init_dt_scan_root, NULL);
>> + =A0 =A0 of_scan_flat_dt(early_init_dt_scan_memory, NULL);
>> +
>> + =A0 =A0 /* Save command line for /proc/cmdline and then parse paramete=
rs */
>> + =A0 =A0 strlcpy(boot_command_line, cmd_line, COMMAND_LINE_SIZE);
>> + =A0 =A0 parse_early_param();
>> +
>> + =A0 =A0 /* This is in an arbitrary spot, but it is temporary. =A0After=
 all
>> + =A0 =A0 =A0* the common code is merged, the structure of the early ini=
t
>> + =A0 =A0 =A0* code will be reevaluated and refactored */
>> + =A0 =A0 early_init_devtree_arch();
>> +
>> + =A0 =A0 lmb_analyze();
>> + =A0 =A0 lmb_dump_all();
>
> So we're assuming that the arch has lmb support, or should we make this
> conditional on CONFIG_HAVE_LMB?

I'm not making any assumptions yet.  I'm just merging the code.  A lot
of it needs to be refactored after the merge.  Feel free to send
patches to rework want you need.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
