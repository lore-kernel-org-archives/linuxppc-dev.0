Return-Path: <miltonm@sullivan.realtime.net>
Date: Sat, 7 Jul 2007 01:18:45 -0500 (CDT)
Subject: [PATCH 00/11] dtc: some fixes, and make asm labels for data
Sender: <miltonm@realtime.net>
From: Milton Miller <miltonm@bga.com>
To: Jon Loeliger <jdl@jdl.com>
Message-Id: <dtc-5-00.miltonm@bga.com>
Cc: linuxppc-dev@ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The following series adds the features of labeling memory reserve
slots and labeling specific bytes or cells of property data.  When
translating from dts to asm, a global symbol is created with the
name matching the label in the dts file.

With these features a program does not need to understand the
flattened device tree headers, offsets, layouts, or alignments to
modify a property's contents.  Instead it can read or write to the
bytes or words addressed by a global symbol.


In addition the series contains 3 fixes to the compiler (one major
- incorrect output, one recognising an input error, and one compiler
warning), a source dtc for use as a testcase, and two formatting
changes to the generated assembly.

I verified the label placement in the asm output and compared the
dts to dtb output with outptut of dts to asm after cc -c ond objcopy
-o binary, the difference was trailing padding of the assembled
version.  I also compared the dts to dts output with the dtb to dts
of the assembled version.  Although I did not include the assembled
output with the testcase, it should be placed in the test directory
when the samples there are upgraded to version 17.

I have not studied the tests directory since the new libfdt test
suite was merged to evaluate how to test the labels point at the
property.

I choose not to attempt writing the labels when generating dts
output at this time, although I did consider it.  The code currently
resolves node references to phandles creating the properties if
needed, so creating dts from dts is already a lossy operation.  I
felt there was no benefit in preserving the labels until there is
a method to read and write some kind of symbol or map file of labels
with dtb input and therefore couldn't justify writing the code to
split the data as it is output.  Such code could be used to avoid
formatting a list of strings as list of cells or bytes.

I did not provide a method to label the address and size fields of
a memory reserve entry.  Although it could be implemented, I didn't
deem it necessary as there is no header before the address field
and placing a label on the size field of a reserve created with the
start-end syntax would be misleading.

I did not include a prefix when generating the labels, matching the
existing labels output on node and property tags.  If code is later
added to change the _dt label prefix used in the header to allow
multiple trees to be linked in one program, a prefix should be added
to the labels to create a a seperate namespace for each dts.

milton
