Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.186]) by ozlabs.org (Postfix) with ESMTP id D04CF67B5E
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Jun 2006 21:11:29 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 2/3] powerpc: Instrument Hypervisor Calls: add wrappers
Date: Thu, 15 Jun 2006 13:09:39 +0200
References: <20060614034756.GA6759@monkey.ibm.com>
	<20060614224040.GH26750@localdomain>
	<20060614235217.GA3876@monkey.ibm.com>
In-Reply-To: <20060614235217.GA3876@monkey.ibm.com>
MIME-Version: 1.0
Message-Id: <200606151309.40360.arnd@arndb.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Cc: Bryan Rosenburg <rosnbrg@us.ibm.com>, Nathan Lynch <ntl@pobox.com>,
	Paul Mackerras <paulus@samba.org>, Christopher Yeoh <cyeoh@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 15 June 2006 01:52, Mike Kravetz wrote:
> I'm really wondering what would be the best way to make these stats
> available to userspace. =A0As mentioned, putting them into sysfs would
> violate the one value/one file rule. =A0The use of /proc is discouraged.
> debugfs was mentioned, but I have never used it. =A0Noticed that debugfs
> was enabled in the default config (at least for pseries). =A0Looks like
> that would be the best alternative. =A0Agree?

Debugfs sounds good. If you use one file per hcall, it's probably as
easy as

static u64 hcall_stats_get(void *data)
{
	unsigned long index =3D (unsigned long)data;
	return read_hcall_count(index);
}
DEFINE_SIMPLE_ATTRIBUTE(hcall_fops, hcall_stats_get, NULL, "%llu\n");

void hcall_stats_create(void)
{
	unsigned long i;
	struct dentry *dir;

	dir =3D debugfs_create_dir("hcall_stats", NULL);
	for (i=3D0; i <=3D MAX_HCALL_OPCODES; i++) {
		char name[16];
		sprintf(name, "%d", i << 2);
		debugfs_create_file(name, 0444, dir, (void *)i, &hcall_fops);
	}
}

	Arnd <><
