Return-Path: <apw@us.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 3FF6E67B97
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Aug 2006 08:22:30 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e32.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k73MMReT022212
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <linuxppc-dev@ozlabs.org>; Thu, 3 Aug 2006 18:22:27 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.6/NCO/VER7.0) with ESMTP id
	k73MMQuP211988
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-dev@ozlabs.org>; Thu, 3 Aug 2006 16:22:26 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k73MMQEd024893
	for <linuxppc-dev@ozlabs.org>; Thu, 3 Aug 2006 16:22:26 -0600
Received: from kvasir.watson.ibm.com (kvasir.watson.ibm.com [9.2.218.19])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k73MMQPb024842
	for <linuxppc-dev@ozlabs.org>; Thu, 3 Aug 2006 16:22:26 -0600
Received: from apw by kvasir.watson.ibm.com with local (Exim 4.52)
	id 1G8laD-0006GH-TG
	for linuxppc-dev@ozlabs.org; Thu, 03 Aug 2006 18:22:25 -0400
Date: Thu, 3 Aug 2006 18:22:25 -0400
To: linuxppc-dev@ozlabs.org
Subject: tool for editing builtin command line
Message-ID: <20060803222225.GA23341@kvasir.watson.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Amos Waterland <apw@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The following is a tool for reading and editing the builtin command line
arguments in Linux zImage files and other bootable files that follow the
same format.  It is useful in a cluster context in which one is booting
the same kernel on many machines with the only difference being their
network autoconfiguration values.  Inspired by a script that Michal
Ostrowski posted earlier.

To see the existing arguments in a bootable image:

 $ ./builtin-cmdline zImage
 console=ttyS0,19200

To put new arguments in the image:

 $ ./builtin-cmdline zImage "ro root=/dev/nfs nfsroot=192.168.0.3:/nfsroot \
                 ip=192.168.0.4::192.168.0.2:255.255.255.0:cluster001:eth0:off"

Signed-off-by: Amos Waterland <apw@us.ibm.com>

---

#!/bin/bash
#
# Copyright (C) 2006 Amos Waterland <apw@us.ibm.com>, IBM Corp.
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

function help()
{
    local name=$1;
    local version=$2;

    echo -e "\`$name' manipulates builtin command line arguments\n" \
	    "\n" \
	    "Usage: $name FILE [ARGS]\n" \
	    " -?, --help     Show this help statement.\n" \
	    "     --version  Show version statement.\n" \
	    "\n" \
	    "Examples: $name zImage\n" \
            "          $name zImage 'console=ttyS0'";
}

function work()
{
    local file=$1;
    local args=$2;
    local off; local siz; local out;

    off=$(objdump -h $file |
       	  gawk -- '{if($2=="__builtin_cmdline") {print strtonum("0x"$6);}}';)

    if [ -z $off ]; then
        echo "error: cannot find command line section in: $file"; return 1;
    fi

    siz=$(objdump -h $file |
       	  gawk -- '{if($2=="__builtin_cmdline") {print strtonum("0x"$3);}}';)

    if [ -z $siz ]; then return 1; fi

    if [ -z "$args" ]; then
        out=$(dd bs=1 if=$file skip=$off count=$siz 2>/dev/null);
        if [ $? -ne 0 ]; then return 1; fi
        echo $out;
    else
        dd if=/dev/zero of=$file bs=1 \
           seek=$off conv=notrunc count=$siz 2>/dev/null
        if [ $? -ne 0 ]; then return 1; fi
        echo -n "$args" | dd \
           of=$file bs=1 seek=$off conv=notrunc count=$siz 2>/dev/null
        if [ $? -ne 0 ]; then return 1; fi
    fi

    return 0;
}

function main()
{
    local args;
    local file;
    local name=builtin-cmdline;
    local version=0.1.0;

    while [ $# -gt 0 ]; do
        case $1 in
        -\? | --help)
            help $name $version; return 1;
            ;;
        --version)
            echo "$name $version"; return 1;
            ;;
        *)
	    if [ -z "$file" ]; then
	        file="$1"; shift;
	    elif [ -z "$args" ]; then
	        args="$1"; shift;
	    else
                help $name $version; return 1;
	    fi
            ;;
        esac
    done

    [ -z "$file" ] && {
	help $name $version; return 1;
    }

    work "$file" "$args" || {
	echo "bailing out because of errors"; return 1;
    }

    return 0;
}

main "$@";
exit $?;
