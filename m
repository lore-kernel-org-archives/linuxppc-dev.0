Return-Path: <jdl@jdl.com>
Received: from jdl.com (jdl.com [208.123.74.7])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9B97BDDF16
	for <linuxppc-dev@ozlabs.org>; Sat, 20 Oct 2007 03:49:52 +1000 (EST)
Received: from jdl (helo=jdl.com) by jdl.com with local-esmtp (Exim 4.63)
	(envelope-from <jdl@jdl.com>) id 1Iivym-0007AE-LR
	for linuxppc-dev@ozlabs.org; Fri, 19 Oct 2007 12:49:49 -0500
To: linuxppc-dev@ozlabs.org
Subject: DTC: DTC {before,after} Comparison Script
Date: Fri, 19 Oct 2007 12:49:48 -0500
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1Iivym-0007AE-LR@jdl.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Guys,

And just for the record, here is the QAD script that
I used to verify that all the existing DTS files in
the arch/powerpc/boot/dts directory are byte-identical
before and after my recent modifications.  Naturally,
all the DTS files are still in "legacy dts-version 0"
still.  But I don't think I broke that mode now. :-)

Feel free to productize or otherwise improve on it...

jdl

----------------------------------------------------------------

#!/usr/bin/perl

my $dtc_old = "dtc/dtc-old";
my $dtc_new = "dtc/dtc-new-debug";

my $basic_options = "-b 0 -f -I dts -O dtb";

my $linux_dts_dir = "linux-2.6/arch/powerpc/boot/dts";

# Yeah, sure, we could, like, readdir() this instead...
my @boards = (
	      "bamboo",
	      "ebony",
	      "ep88xc",
	      "holly",
	      "kilauea",
	      "kuroboxHD",
	      "kuroboxHG",
	      "lite5200",
	      "lite5200b",
	      "mpc7448hpc2",
	      "mpc8272ads",
	      "mpc8313erdb",
	      "mpc832x_mds",
	      "mpc832x_rdb",
	      "mpc8349emitx",
	      "mpc8349emitxgp",
	      "mpc834x_mds",
	      "mpc836x_mds",
	      "mpc8540ads",
	      "mpc8541cds",
	      "mpc8544ds",
	      "mpc8548cds",
	      "mpc8555cds",
	      "mpc8560ads",
	      "mpc8568mds",
	      "mpc8572ds",
	      "mpc8610_hpcd",
	      "mpc8641_hpcn",
	      "mpc866ads",	# Feh.  Bad node references...
	      "mpc885ads",
	      "pq2fads",
	      "prpmc2800",
	      "ps3",
	      "sequoia",
	      "walnut",
);

foreach my $board (@boards) {
	my $dts_file = "$linux_dts_dir/$board.dts";

	my $old_dtb_file = "/tmp/$board.dtb.old";
	my $new_dtb_file = "/tmp/$board.dtb.new";

	my $cmd_old = "$dtc_old $basic_options -o $old_dtb_file $dts_file";
	my $cmd_new = "$dtc_new $basic_options -o $new_dtb_file $dts_file";
	my $cmd_cmp = "cmp $old_dtb_file $new_dtb_file";

	print "------------------------------------------------\n";
	print "OLD: $cmd_old\n";
	unlink($old_dtb_file) if (-f $old_dtb_file);
	system("$cmd_old >& /dev/null");
	my $status = $?;
	if ($status) {
		print "    FAILED to run old DTC on $board\n";
	}

	print "NEW: $cmd_new\n";
	unlink($new_dtb_file) if (-f $new_dtb_file);
	system("$cmd_new >& /dev/null");
	$status = $?;
	if ($status) {
		print "    FAILED to run new DTC on $board\n";
	}

	if (-f $old_dtb_file && -f $new_dtb_file) {
	    print "CMP: $cmd_cmp\n";
	    system($cmd_cmp);
	    $status = $?;
	    if ($status) {
		print "    FAILED $board\n";
	    }
	} else {
	    printf "    FAILED: Missing dtb file\n";
	}
}
