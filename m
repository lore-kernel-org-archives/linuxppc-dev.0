Date: Thu, 16 Dec 1999 11:01:23 -0800
From: "David N. Welton" <davidw@linuxcare.com>
To: "LinuxPPC Developer's List" <linuxppc-dev@lists.linuxppc.org>
Subject: xmon stack trace tool
Message-ID: <19991216110123.F5452@bassano.linuxcare.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I wrote a little tool in Python that, when given an xmon stack trace
on the command line, gives you a list of the equivalment function
names by sifting through System.map (xmonstacktrace must be run in the
same directory as System.map).

Here it is:

----
#!/usr/bin/python
# xmonstacktrace.py, by David N. Welton <davidw@linuxcare.com>
# Example:
# @hal [/usr/local/src/linux] $ time xmonstracktrace.py c00223f0 c0028940 c0028ac0 c00295d8 c0026d7c c0027380 c0026694 c0148900 c013f71c c0003738 
# c002235c c0022524 = 'shrink_mmap', c00223f0
# c00288f8 c00289c4 = 'do_try_to_free_pages', c0028940
# c0028a88 c0028adc = 'try_to_free_pages', c0028ac0
# c0029544 c00298a8 = '__get_free_pages', c00295d8
# c0026c50 c002710c = 'kmem_cache_grow', c0026d7c
# c00271a4 c002741c = 'kmem_cache_alloc', c0027380
# c002654c c0026a9c = 'kmem_cache_create', c0026694
# c01488d0 c01489bc = 'kmem_cache_sizes_init', c0148900
# c013f5dc c013f7a8 = 'start_kernel', c013f71c
# c000365c c00038a8 = 'start_here', c0003738
# Computed with 116 compares.

import sys
import string

addresses = []
records = []

class Record:
    def __init__(self, lower, upper, symbol):
        self.lower = lower
        self.upper = upper
        self.symbol = symbol

    def __repr__(self):
        return "%s %s = '%s'" %(self.lower, self.upper, self.symbol)

    def __cmp__(self, other):
        if cmp(other, self.lower) < 0:
            return -1 # to low
        elif cmp(other, self.upper) > 0:
            return 1 # to high
        else:
            return 0

def getSystemMap(recs):
    mapfile = open("System.map")
    saveline = "00000000"
    symbol = ""
    n = 0

    while 1:
        ln = mapfile.readline()
        if ln == "":
            break

        splitln = string.split(ln)
        recs.append(Record(saveline, splitln[0], symbol))
        saveline = splitln[0]
        symbol = splitln[2]
            
    recs.append(Record(splitln[0], "ffffffff", symbol))
    mapfile.close()
            
def getrecords(recs, addrs):
    ops = 0
    for a in addrs:
        start = 0
        end = len(recs)
        n = end

        while 1:
            n = int((end + start) / 2) 
            res = cmp(a, recs[n])
            ops = ops + 1
            if res < 0:
                start = n
            elif res > 0:
                end = n
            else:
                print "%s, %s\n" %(recs[n], a),
                break

    return ops

i = 1
while i < len(sys.argv):
    addresses.append(sys.argv[i])
    i = i + 1

getSystemMap(records)
print "Computed with %d compares." %(getrecords(records, addresses))
----

Ciao,
-- 
David N. Welton, Developer, Linuxcare, Inc.
415.354.4878 x241 tel, 415.701.7457 fax
davidw@linuxcare.com, http://www.linuxcare.com/
Linuxcare. At the center of Linux.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
