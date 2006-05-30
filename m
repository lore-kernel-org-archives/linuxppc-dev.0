Return-Path: <mostrows@watson.ibm.com>
Received: from igw2.watson.ibm.com (igw2.watson.ibm.com [129.34.20.6])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9765C67A3E
	for <linuxppc-dev@ozlabs.org>; Tue, 30 May 2006 12:27:13 +1000 (EST)
Received: from sp1n293en1.watson.ibm.com (sp1n293en1.watson.ibm.com
	[129.34.20.41])
	by igw2.watson.ibm.com (8.12.11.20060308/8.13.1/8.13.1-2005-04-25 igw)
	with ESMTP id k4U2RfXs021311
	for <linuxppc-dev@ozlabs.org>; Mon, 29 May 2006 22:27:41 -0400
Received: from sp1n293en1.watson.ibm.com (localhost [127.0.0.1])
	by sp1n293en1.watson.ibm.com (8.11.7-20030924/8.11.7/01-14-2004_2) with
	ESMTP id k4U2R9D209856
	for <linuxppc-dev@ozlabs.org>; Mon, 29 May 2006 22:27:09 -0400
Received: from mgsmtp00.watson.ibm.com (mgsmtp00.watson.ibm.com [9.2.40.58])
	by sp1n293en1.watson.ibm.com (8.11.7-20030924/8.11.7/01-14-2004_1) with
	ESMTP id k4U2R8k208760
	for <linuxppc-dev@ozlabs.org>; Mon, 29 May 2006 22:27:08 -0400
Received: from kitch0.watson.ibm.com (kitch0.watson.ibm.com [9.2.224.107])
	by mgsmtp00.watson.ibm.com (8.12.11/8.12.11/2005/09/01) with ESMTP id
	k4U3Kr6n002496
	for <linuxppc-dev@ozlabs.org>; Mon, 29 May 2006 23:20:53 -0400
Subject: Re: [PATCH] Provide mechanism for editing builtin command-line in
	zImage binary.
From: Michal Ostrowski <mostrows@watson.ibm.com>
To: linuxppc-dev@ozlabs.org
In-Reply-To: <11489544631499-git-send-email-mostrows@watson.ibm.com>
References: <11489544631499-git-send-email-mostrows@watson.ibm.com>
Content-Type: text/plain
Date: Mon, 29 May 2006 22:27:02 -0400
Message-Id: <1148956023.25048.83.camel@brick>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

For reference, below is a shell script I use to edit the command-line
embedded in a zImage.


-- 
Michal Ostrowski <mostrows@watson.ibm.com>



#!/bin/bash
#
# Copyright (C) 2006 Michal Ostrowski <mostrows@watson.ibm.com>, IBM Corp.
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA

usage(){
    echo 'set_builtin_cmdline [--cmd <file>] <input_obj> [<output_obj>]'
    echo '    Sets the builtin command line embedded in an object file.'
    echo
    echo '    If <output_obj> is not specified, <input_obj> is modified'
    echo '    in place.'
    echo '    If --cmd <file> argument is present contents of embedded'
    echo '    command line will be copied from <file>, otherwise from stdin.'
    exit 1
}

cmd_file=

while case "$#" in 0) break ;; esac
do
  
        case "$1" in
        --cmd)
		case "$#" in
		    1)
			usage ;;
		    *)
			cmd_file="$2";
			shift;;
		esac;;
        *)
                set x "$@"
                shift
                break ;;
        esac
        shift
done

if [ "$#" -lt 1 ]; then
    echo "No input object specified." ; 
    usage;
fi

if [ "$#" -gt 2 ]; then
    echo "Unrecognized arguments: $@";
    usage;
fi


infile=$1
shift;

if [ ! -r "$infile" ] ; then 
    echo "Can't read '$infile'."; 
    usage;
fi

if [ "$#" -eq 0 ] ; then
    outfile=$infile;
else
    outfile=$1;
    if ! cp $infile $outfile ;  then
	echo "Can't create output: '$outfile' $?" 
	usage;
    fi
    shift;
fi

offset=$(objdump -h  $infile | \
         gawk -- '{if($2=="__builtin_cmdline") {print strtonum("0x" $6);}}')
size=$(objdump -h  $infile | \
       gawk -- '{if($2=="__builtin_cmdline") {print strtonum("0x" $3);}}')

if [ "$cmd_file" ] ; then
    [ -r "$cmd_file" ] || (echo "Can't read '$cmd_file'." ; usage);
    cmdline=$(cat $cmd_file);
else
    cmdline=$(cat);
fi

if [ "x$offset" != "x" ] ; then 
    if [ "$offset" -ne 0  ] ; then
	set -e
	# Zero the destination buffer first
	exec 2>/dev/null
	dd if=/dev/zero of=$outfile bs=1 seek=$offset conv=notrunc count=$size
	echo -n "$cmdline" | \
	    dd of=$outfile bs=1 seek=$offset conv=notrunc count=$size
	exit $?
    fi
fi
